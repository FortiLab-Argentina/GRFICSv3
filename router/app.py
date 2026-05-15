from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
import subprocess
import json, os, functools, time, glob, re
from werkzeug.security import generate_password_hash, check_password_hash
from collections import Counter
from pathlib import Path
from datetime import datetime

app = Flask(__name__)

INTERFACE_LABELS = {
    "eth0": "Admin",
    "eth1": "LAN",
    "eth2": "WAN"
}

# SECRET_KEY is required for sessions. Set via env var in compose or host.
# For quick local testing you can hardcode, but better: export SECRET_KEY before starting.
app.secret_key = os.environ.get("FWUI_SECRET_KEY", "dev-secret-key-change-me")

# default user (will be persisted when load_config runs if config exists)
DEFAULT_USER = {"username": "admin", "password": "password"}  # intentionally weak for labs

credentials = DEFAULT_USER.copy()  # dict with username/password

LOG_FILE = "/var/log/ulog/netfilter_log.json"
FIREWALL_RULES_PATH = "/etc/firewall/rules"
CONFIG_PATH = "/etc/firewall/config.json"
IDS_ALERTS_FILE = "/etc/suricata/alerts.json"
IDS_RULES_FILE = "/etc/suricata/rules/local.rules"
ICS_SUBNET = "192.168.95.0/24"   # trusted LAN — default allow outbound

DNS_CONFIG_PATH = "/etc/firewall/dns_config.json"
WG_CONFIG_PATH = "/etc/firewall/wg_config.json"
WG_CONF_PATH = "/etc/wireguard/wg0.conf"
WG_VPN_SUBNET = "10.100.0.0/24"
WG_SERVER_ADDR = "10.100.0.1/24"
DNS_HOSTS_PATH = "/etc/firewall/dns_hosts"
DNS_BLOCKED_PATH = "/etc/firewall/dns_blocked.conf"
DNSMASQ_LOG = "/var/log/dnsmasq/dnsmasq.log"

pending_rules = []
dirty = False

def parse_firewall_logs(limit=100):
    entries = []
    try:
        with open(LOG_FILE) as f:
            for line in f:
                data = json.loads(line)
                in_iface = INTERFACE_LABELS.get(data.get("oob.in"), data.get("oob.in", "?"))
                entries.append({
                    "time": datetime.fromisoformat(data.get("timestamp")).strftime("%H:%M:%S"),
                    "action": data.get("oob.prefix", "").replace("FW ", "").strip(": "),
                    "proto": {6:"TCP",17:"UDP",1:"ICMP"}.get(data.get("ip.protocol"), str(data.get("ip.protocol"))),
                    "src": f"{data.get('src_ip','?')}:{data.get('src_port','')}",
                    "dst": f"{data.get('dest_ip','?')}:{data.get('dest_port','')}",
                    "iface": f"{in_iface}",
                })
        entries = entries[-limit:]  # last N lines
    except FileNotFoundError:
        pass
    return entries

def get_recent_alerts(limit=50):
    eve_path = Path("/var/log/suricata/eve.json")
    alerts = []
    if not eve_path.exists():
        return alerts
    with eve_path.open() as f:
        for line in f:
            try:
                event = json.loads(line)
                if event.get("event_type") == "alert":
                    alerts.append({
                        "timestamp": event.get("timestamp"),
                        "src": event.get("src_ip"),
                        "dst": event.get("dest_ip"),
                        "proto": event.get("proto"),
                        "signature": event["alert"].get("signature"),
                    })
            except json.JSONDecodeError:
                continue
    return alerts[-limit:]


RULES_DIR = "/etc/suricata/rules"


def parse_rule_lines(text):
    # Rejoin lines ending with \ before parsing (multi-line rule format)
    logical_lines = []
    buf = ""
    for raw in text.splitlines():
        stripped = raw.rstrip()
        if stripped.endswith("\\"):
            buf += stripped[:-1]
        else:
            buf += stripped
            logical_lines.append(buf)
            buf = ""
    if buf:
        logical_lines.append(buf)

    rules = []
    for line in logical_lines:
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        msg_m = re.search(r'msg:"([^"]+)"', line)
        sid_m = re.search(r'\bsid:(\d+)', line)
        rules.append({
            "sid": sid_m.group(1) if sid_m else "—",
            "msg": msg_m.group(1) if msg_m else line[:80],
        })
    return rules


def load_builtin_rules():
    rules = []
    for path in sorted(glob.glob(f"{RULES_DIR}/*.rules")):
        if os.path.basename(path) == "local.rules":
            continue
        try:
            with open(path) as f:
                text = f.read()
        except OSError:
            continue
        label = os.path.basename(path).replace(".rules", "")
        for r in parse_rule_lines(text):
            r["file"] = label
            rules.append(r)
    return rules


def load_json(path, default=[]):
    try:
        with open(path, "r") as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return default


def save_json(path, data):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        json.dump(data, f, indent=2)


DEFAULT_RULES = [
    {
        "iface_in": "",
        "iface_out": "",
        "src": "0.0.0.0/0",
        "dst": "0.0.0.0/0",
        "proto": "all",
        "dport": "",
        "action": "ACCEPT",
        "comment": "TEMP - allow all traffic for troubleshooting - DO NOT LEAVE IN PRODUCTION",
    }
]

def load_config():
    global pending_rules, dirty, credentials
    if os.path.exists(CONFIG_PATH):
        with open(CONFIG_PATH) as f:
            data = json.load(f)
            pending_rules = data.get("rules", [])
            if "auth" in data:
                credentials = data["auth"]
    else:
        pending_rules = DEFAULT_RULES.copy()
        save_config()
    dirty = False


def save_config():
    data = {"rules": pending_rules, "auth": credentials}
    with open(CONFIG_PATH, "w") as f:
        json.dump(data, f, indent=2)


# --- traffic stats helpers ---

_iface_prev = {}  # {iface: (monotonic_time, {rx_bytes, rx_packets, tx_bytes, tx_packets})}

def read_proc_net_dev():
    stats = {}
    try:
        with open('/proc/net/dev') as f:
            for line in f.readlines()[2:]:
                parts = line.split()
                if len(parts) < 11:
                    continue
                iface = parts[0].rstrip(':')
                stats[iface] = {
                    'rx_bytes':   int(parts[1]),
                    'rx_packets': int(parts[2]),
                    'tx_bytes':   int(parts[9]),
                    'tx_packets': int(parts[10]),
                }
    except FileNotFoundError:
        pass
    return stats


def get_interface_rates():
    now = time.monotonic()
    current = read_proc_net_dev()
    rates = {}
    for iface in INTERFACE_LABELS:
        if iface not in current:
            rates[iface] = {'rx_bps': 0.0, 'rx_pps': 0.0, 'tx_bps': 0.0, 'tx_pps': 0.0}
            continue
        cur = current[iface]
        if iface in _iface_prev:
            prev_time, prev = _iface_prev[iface]
            dt = now - prev_time
            if dt > 0:
                rates[iface] = {
                    'rx_bps': max(0.0, (cur['rx_bytes']   - prev['rx_bytes'])   / dt),
                    'rx_pps': max(0.0, (cur['rx_packets'] - prev['rx_packets']) / dt),
                    'tx_bps': max(0.0, (cur['tx_bytes']   - prev['tx_bytes'])   / dt),
                    'tx_pps': max(0.0, (cur['tx_packets'] - prev['tx_packets']) / dt),
                }
            else:
                rates[iface] = {'rx_bps': 0.0, 'rx_pps': 0.0, 'tx_bps': 0.0, 'tx_pps': 0.0}
        else:
            rates[iface] = {'rx_bps': 0.0, 'rx_pps': 0.0, 'tx_bps': 0.0, 'tx_pps': 0.0}
        _iface_prev[iface] = (now, cur)
    return rates


def parse_conntrack():
    entries = []
    try:
        with open('/proc/net/nf_conntrack') as f:
            for line in f:
                parts = line.split()
                if len(parts) < 5:
                    continue
                l4proto = parts[2]
                ttl = int(parts[4])
                # TCP has a state word at position 5 before the key=value pairs
                state = ''
                if l4proto == 'tcp' and len(parts) > 5 and '=' not in parts[5]:
                    state = parts[5]
                # Collect key=value pairs; first occurrence = original direction
                kv = {}
                for p in parts:
                    if '=' in p:
                        k, v = p.split('=', 1)
                        if k not in kv:
                            kv[k] = v
                entries.append({
                    'proto': l4proto,
                    'state': state,
                    'ttl':   ttl,
                    'src':   kv.get('src',   '?'),
                    'dst':   kv.get('dst',   '?'),
                    'sport': kv.get('sport', ''),
                    'dport': kv.get('dport', ''),
                })
    except (FileNotFoundError, ValueError):
        pass
    return entries


def get_top_talkers(entries, n=10):
    counts = Counter(e['src'] for e in entries if e['src'] != '?')
    return [{'ip': ip, 'connections': count} for ip, count in counts.most_common(n)]


# --- dnsmasq helpers ---

def load_dns_config():
    try:
        with open(DNS_CONFIG_PATH) as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return {"hosts": [], "blocked": []}


def save_dns_config(config):
    with open(DNS_CONFIG_PATH, "w") as f:
        json.dump(config, f, indent=2)


def apply_dns_config(config):
    """Write dnsmasq host and block files then restart dnsmasq via supervisorctl."""
    host_lines = [f"{h['ip']}\t{h['hostname']}" for h in config.get("hosts", [])]
    with open(DNS_HOSTS_PATH, "w") as f:
        f.write("\n".join(host_lines) + ("\n" if host_lines else ""))

    block_lines = [f"address=/{b['domain']}/#" for b in config.get("blocked", [])]
    with open(DNS_BLOCKED_PATH, "w") as f:
        f.write("\n".join(block_lines) + ("\n" if block_lines else ""))

    subprocess.run(["supervisorctl", "restart", "dnsmasq"], check=False)


def get_dns_queries(limit=100):
    queries = []
    try:
        with open(DNSMASQ_LOG) as f:
            for line in f:
                if "query[" not in line:
                    continue
                parts = line.strip().split()
                q_idx = next((i for i, p in enumerate(parts) if "query[" in p), None)
                if q_idx is None:
                    continue
                try:
                    qtype  = parts[q_idx].split("[")[1].rstrip("]")
                    domain = parts[q_idx + 1]
                    src    = parts[q_idx + 3] if len(parts) > q_idx + 3 else "?"
                    queries.append({
                        "time":   " ".join(parts[:3]),
                        "type":   qtype,
                        "domain": domain,
                        "src":    src,
                    })
                except (IndexError, ValueError):
                    continue
    except FileNotFoundError:
        pass
    return queries[-limit:]


# --- wireguard helpers ---

def load_wg_config():
    try:
        with open(WG_CONFIG_PATH) as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        return {"server": {}, "peers": []}


def save_wg_config(config):
    os.makedirs(os.path.dirname(WG_CONFIG_PATH), exist_ok=True)
    with open(WG_CONFIG_PATH, "w") as f:
        json.dump(config, f, indent=2)


def wg_genkey():
    priv = subprocess.check_output(["wg", "genkey"], text=True).strip()
    pub = subprocess.check_output(["wg", "pubkey"], input=priv, text=True).strip()
    return priv, pub


def write_wg_conf(config):
    server = config.get("server", {})
    lines = [
        "[Interface]",
        f"PrivateKey = {server['private_key']}",
        f"ListenPort = {server.get('listen_port', 51820)}",
        f"Address = {server.get('address', WG_SERVER_ADDR)}",
        "",
    ]
    for peer in config.get("peers", []):
        lines += [
            f"# {peer.get('name', 'peer')}",
            "[Peer]",
            f"PublicKey = {peer['public_key']}",
            f"AllowedIPs = {peer['allowed_ips']}",
            "",
        ]
    os.makedirs("/etc/wireguard", exist_ok=True)
    with open(WG_CONF_PATH, "w") as f:
        f.write("\n".join(lines))


def _ensure_wg_masquerade():
    r = subprocess.run(
        ["iptables", "-t", "nat", "-C", "POSTROUTING", "-s", WG_VPN_SUBNET, "-j", "MASQUERADE"],
        capture_output=True,
    )
    if r.returncode != 0:
        subprocess.run(
            ["iptables", "-t", "nat", "-A", "POSTROUTING", "-s", WG_VPN_SUBNET, "-j", "MASQUERADE"],
            check=False,
        )


def apply_wg(config):
    write_wg_conf(config)
    subprocess.run(["wg-quick", "down", "wg0"], capture_output=True)
    result = subprocess.run(["wg-quick", "up", "wg0"], capture_output=True, text=True)
    if result.returncode == 0:
        _ensure_wg_masquerade()
    return result


def parse_wg_show():
    """Parse `wg show wg0 dump` into a dict keyed by peer public key."""
    try:
        out = subprocess.check_output(
            ["wg", "show", "wg0", "dump"], text=True, stderr=subprocess.DEVNULL
        )
    except subprocess.CalledProcessError:
        return {}
    status = {}
    for line in out.strip().splitlines()[1:]:  # skip interface line
        parts = line.split("\t")
        if len(parts) < 8:
            continue
        pubkey = parts[0]
        last_hs = int(parts[4]) if parts[4] != "0" else 0
        status[pubkey] = {
            "endpoint": parts[2] if parts[2] != "(none)" else None,
            "allowed_ips": parts[3],
            "last_handshake": last_hs,
            "rx_bytes": int(parts[5]),
            "tx_bytes": int(parts[6]),
        }
    return status


def wg_iface_up():
    return subprocess.run(["ip", "link", "show", "wg0"], capture_output=True).returncode == 0


# --- login helper/decorator ---
def login_required(view):
    @functools.wraps(view)
    def wrapped_view(*args, **kwargs):
        if not session.get("logged_in"):
            return redirect(url_for("login", next=request.path))
        return view(*args, **kwargs)
    return wrapped_view

@app.route("/login", methods=["GET", "POST"])
def login():
    next_url = request.args.get("next") or url_for("dashboard")
    if request.method == "POST":
        username = request.form.get("username", "")
        password = request.form.get("password", "")
        # simple check against stored credentials
        if username == credentials.get("username") and password == credentials.get("password"):
            session["logged_in"] = True
            session["username"] = username
            flash("Logged in", "success")
            return redirect(next_url)
        else:
            flash("Invalid username or password", "danger")
    return render_template("login.html", next=next_url)

@app.route("/logout")
def logout():
    session.clear()
    flash("Logged out", "info")
    return redirect(url_for("login"))

# --- protect routes: add @login_required above routes that need protection ---
# Example: protect index and all modifying endpoints

def is_dirty():
    active = subprocess.check_output(["iptables-save"], text=True)
    saved = open(CONFIG_PATH).read() if os.path.exists(CONFIG_PATH) else ""
    return saved not in active


def parse_iptables_rules():
    raw = subprocess.check_output(["iptables", "-S"], text=True).splitlines()
    idx = 0
    rules = []
    for line in raw:
        if not line.startswith('-A'):  # only actual rules
            continue
        idx += 1
        parts = line.split()
        rule = {
            'index': idx,
            'chain': parts[1],
            'iface_in': next((parts[i+1] for i,p in enumerate(parts) if p == '-i'), ''),
            'iface_out': next((parts[i+1] for i,p in enumerate(parts) if p == '-o'), ''),
            'src': next((parts[i+1] for i,p in enumerate(parts) if p == '-s'), 'any'),
            'dst': next((parts[i+1] for i,p in enumerate(parts) if p == '-d'), 'any'),
            'proto': next((parts[i+1] for i,p in enumerate(parts) if p == '-p'), 'any'),
            'dport': next((parts[i+1] for i,p in enumerate(parts) if p == '--dport'), 'any'),
            'action': parts[-1],
        }
        rules.append(rule)
    return rules

@app.route("/dashboard")
@app.route("/")
@login_required
def dashboard():
    return render_template("dashboard.html", active_page="dashboard", labels=INTERFACE_LABELS)


@app.route("/api/stats")
@login_required
def api_stats():
    entries = parse_conntrack()
    rates = get_interface_rates()
    return jsonify({
        'connection_count': len(entries),
        'interfaces': {
            iface: {'label': INTERFACE_LABELS.get(iface, iface), **data}
            for iface, data in rates.items()
        },
        'top_talkers': get_top_talkers(entries),
    })


@app.route("/states")
@login_required
def states():
    return render_template("states.html", active_page="states")


_CLOSED_STATES = {'TIME_WAIT', 'CLOSE', 'CLOSE_WAIT', 'LAST_ACK'}

@app.route("/api/states")
@login_required
def api_states():
    entries = [e for e in parse_conntrack()
               if e['state'] not in _CLOSED_STATES
               and e['src'] != '127.0.0.1' and e['dst'] != '127.0.0.1']
    return jsonify({'states': entries, 'count': len(entries)})


@app.route("/firewall", endpoint="index")
@app.route("/index")
@login_required
def firewall():
    global dirty
    user = session.get("username")
    return render_template("firewall.html", rules=pending_rules, labels=INTERFACE_LABELS, dirty=dirty, user=user)


@app.route("/delete", methods=["POST"])
@login_required
def delete_rule():
    global dirty
    idx = int(request.form["rule_num"])
    if 0 <= idx < len(pending_rules):
        del pending_rules[idx]
        save_config()
        dirty = True
    return redirect(url_for("index"))


@app.route("/add", methods=["POST"])
@login_required
def add_rule():
    global dirty
    iface_in = request.form.get("iface_in") 
    iface_out = request.form.get("iface_out") 
    src = request.form.get("src") or "0.0.0.0/0" 
    dst = request.form.get("dst") or "0.0.0.0/0" 
    proto = request.form.get("proto") 
    dport = request.form.get("dport") 
    action = request.form.get("action")
    if not src or src.lower() == "any": 
        src = "0.0.0.0/0" 
    if not dst or dst.lower() == "any": 
        dst = "0.0.0.0/0" 

    comment = request.form.get("comment", "").strip()
    rule = {
        "iface_in": iface_in,
        "iface_out": iface_out,
        "src": src,
        "dst": dst,
        "proto": proto,
        "dport": dport,
        "action": action,
        "comment": comment,
    }

    pending_rules.append(rule)
    save_config()
    dirty = True

    return redirect(url_for("index"))


@app.route("/move", methods=["POST"])
@login_required
def move_rule():
    global dirty
    idx = int(request.form["rule_num"])
    direction = request.form["direction"]

    if direction == "up" and idx > 0:
        pending_rules[idx - 1], pending_rules[idx] = pending_rules[idx], pending_rules[idx - 1]
    elif direction == "down" and idx < len(pending_rules) - 1:
        pending_rules[idx + 1], pending_rules[idx] = pending_rules[idx], pending_rules[idx + 1]

    save_config()
    dirty = True
    return redirect(url_for("index"))


def build_iptables_rules(rules):
    """Return an iptables-restore compatible ruleset string for the given rule list."""
    lines = [
        "*filter",
        ":INPUT ACCEPT [0:0]",
        ":FORWARD DROP [0:0]",
        ":OUTPUT ACCEPT [0:0]",
        ":LOGDROP - [0:0]",
        ":LOGREJECT - [0:0]",
        "-A LOGDROP -m limit --limit 5/second -j NFLOG --nflog-group 1 --nflog-prefix \"FW DROP: \" ",
        "-A LOGDROP -j DROP",
        "-A LOGREJECT -m limit --limit 5/second -j NFLOG --nflog-group 1 --nflog-prefix \"FW REJECT: \" ",
        "-A LOGREJECT -j REJECT",
        # Stateful base rules: pass return traffic, drop invalid packets
        "-A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT",
        "-A FORWARD -m conntrack --ctstate INVALID -j DROP",
    ]
    for r in rules:
        proto = r['proto']
        if proto == 'all':
            line = f"-A FORWARD -s {r['src']} -d {r['dst']}"
        else:
            line = f"-A FORWARD -p {proto} -s {r['src']} -d {r['dst']}"
        if r.get('iface_in'): line += f" -i {r['iface_in']}"
        if r.get('iface_out'): line += f" -o {r['iface_out']}"
        if r.get('dport') and proto in ['tcp', 'udp']: line += f" --dport {r['dport']}"
        if r["action"] in ["DROP", "REJECT"]:
            line += f" -j LOG{r['action']}"
        else:
            line += f" -j {r['action']}"
        lines.append(line)
    # Allow forwarding to/from WireGuard VPN interface when it's up
    lines.append("-A FORWARD -i wg0 -j ACCEPT")
    lines.append("-A FORWARD -o wg0 -j ACCEPT")
    # Default allow for ICS-originated traffic (trusted → untrusted).
    # Match on source subnet rather than interface name — interface assignment
    # is not deterministic in Docker containers.
    lines.append(f"-A FORWARD -s {ICS_SUBNET} -j ACCEPT")
    # Catch-all: log and drop everything else (untrusted inbound not matched above)
    lines.append("-A FORWARD -j LOGDROP")
    lines.append("COMMIT")
    return "\n".join(lines) + "\n"


def _apply_rules_now(rules):
    """Write the iptables ruleset for `rules` to disk and load it. Returns the proc result."""
    os.makedirs(os.path.dirname(FIREWALL_RULES_PATH), exist_ok=True)
    rules_text = build_iptables_rules(rules)
    with open(FIREWALL_RULES_PATH, "w") as f:
        f.write(rules_text)
    subprocess.run(["iptables", "-F", "FORWARD"], check=False)
    return subprocess.run(["iptables-restore", "-n", FIREWALL_RULES_PATH])


@app.route("/apply", methods=["POST"])
@login_required
def apply_changes():
    load_config()
    proc = _apply_rules_now(pending_rules)
    if proc.returncode != 0:
        flash("Error applying firewall rules!", "danger")
    else:
        flash("Firewall rules applied successfully.", "success")
    save_config()
    return redirect(url_for("index"))

@app.route("/revert", methods=["POST"])
@login_required
def revert_changes():
    global dirty
    rules = parse_iptables_rules()
    pending_rules = rules
    save_config()
    dirty = False
    flash("Reverted to active iptables configuration", "info")
    return redirect(url_for("index"))


@app.route("/ids")
@login_required
def ids():
    # Load existing rules as flat text
    try:
        with open(IDS_RULES_FILE, "r") as f:
            rule_text = f.read()
    except FileNotFoundError:
        rule_text = ""

    alerts = get_recent_alerts()
    builtin_rules = load_builtin_rules()
    stats = {
        "status": "Running",
        "alerts_today": len(alerts),
        "rules_count": len(rule_text.strip().splitlines()) if rule_text.strip() else 0,
        "builtin_count": len(builtin_rules),
    }

    return render_template(
        "ids.html",
        active_page="ids",
        alerts=alerts,
        rule_text=rule_text,
        builtin_rules=builtin_rules,
        stats=stats,
    )


@app.route("/ids/save_rules", methods=["POST"])
@login_required
@admin_required
def save_rules():
    new_rules = request.form.get("rules_text", "")
    os.makedirs(os.path.dirname(IDS_RULES_FILE), exist_ok=True)
    with open(IDS_RULES_FILE, "w") as f:
        f.write(new_rules.strip() + "\n")

    try:
        subprocess.run(["pkill", "-USR2", "Suricata-Main"], check=False)
        flash("Rules saved and Suricata reloaded.", "success")
    except Exception as e:
        flash(f"Rules saved, but reload failed: {e}", "warning")

    return redirect(url_for("ids"))



@app.route("/firewall/logs")
@login_required
def firewall_logs():
    entries = parse_firewall_logs(limit=200)
    user = session.get("username")
    return render_template("firewall_logs.html", entries=entries, user=user)


@app.route("/dns")
@login_required
def dns():
    config = load_dns_config()
    queries = get_dns_queries(limit=50)
    return render_template("dns.html", active_page="dns",
                           hosts=config.get("hosts", []),
                           blocked=config.get("blocked", []),
                           queries=queries)


@app.route("/dns/add_host", methods=["POST"])
@login_required
def dns_add_host():
    hostname = request.form.get("hostname", "").strip().lower()
    ip = request.form.get("ip", "").strip()
    comment = request.form.get("comment", "").strip()
    if hostname and ip:
        config = load_dns_config()
        config["hosts"].append({"hostname": hostname, "ip": ip, "comment": comment})
        save_dns_config(config)
        apply_dns_config(config)
        flash(f"Host entry added: {hostname} → {ip}", "success")
    else:
        flash("Hostname and IP are required.", "danger")
    return redirect(url_for("dns"))


@app.route("/dns/delete_host", methods=["POST"])
@login_required
def dns_delete_host():
    idx = int(request.form["idx"])
    config = load_dns_config()
    if 0 <= idx < len(config["hosts"]):
        removed = config["hosts"].pop(idx)
        save_dns_config(config)
        apply_dns_config(config)
        flash(f"Host entry removed: {removed['hostname']}", "success")
    return redirect(url_for("dns"))


@app.route("/dns/add_block", methods=["POST"])
@login_required
def dns_add_block():
    # Strip leading wildcards/dots so "*.evil.com" and "evil.com" both become "evil.com"
    domain = request.form.get("domain", "").strip().lower().lstrip("*.").strip(".")
    comment = request.form.get("comment", "").strip()
    if domain:
        config = load_dns_config()
        config["blocked"].append({"domain": domain, "comment": comment})
        save_dns_config(config)
        apply_dns_config(config)
        flash(f"Domain blocked: {domain}", "success")
    else:
        flash("Domain is required.", "danger")
    return redirect(url_for("dns"))


@app.route("/dns/delete_block", methods=["POST"])
@login_required
def dns_delete_block():
    idx = int(request.form["idx"])
    config = load_dns_config()
    if 0 <= idx < len(config["blocked"]):
        removed = config["blocked"].pop(idx)
        save_dns_config(config)
        apply_dns_config(config)
        flash(f"Block removed: {removed['domain']}", "success")
    return redirect(url_for("dns"))


@app.route("/api/dns/queries")
@login_required
def api_dns_queries():
    queries = get_dns_queries(limit=100)
    return jsonify({"queries": queries, "count": len(queries)})


# --- wireguard routes ---

@app.route("/vpn")
@login_required
def vpn():
    config = load_wg_config()
    peer_status = parse_wg_show()
    return render_template(
        "wireguard.html",
        active_page="vpn",
        config=config,
        peer_status=peer_status,
        iface_up=wg_iface_up(),
    )


@app.route("/vpn/setup", methods=["POST"])
@login_required
def vpn_setup():
    config = load_wg_config()
    if config.get("server", {}).get("private_key"):
        flash("WireGuard is already initialized.", "info")
        return redirect(url_for("vpn"))
    priv, pub = wg_genkey()
    config["server"] = {
        "private_key": priv,
        "public_key": pub,
        "listen_port": 51820,
        "address": WG_SERVER_ADDR,
    }
    config.setdefault("peers", [])
    save_wg_config(config)
    result = apply_wg(config)
    if result.returncode == 0:
        flash("WireGuard initialized and started.", "success")
    else:
        flash(f"Initialized but failed to start: {result.stderr}", "danger")
    return redirect(url_for("vpn"))


@app.route("/vpn/toggle", methods=["POST"])
@login_required
def vpn_toggle():
    if wg_iface_up():
        subprocess.run(["wg-quick", "down", "wg0"], check=False)
        flash("WireGuard stopped.", "info")
    else:
        config = load_wg_config()
        result = apply_wg(config)
        if result.returncode == 0:
            flash("WireGuard started.", "success")
        else:
            flash(f"Failed to start: {result.stderr}", "danger")
    return redirect(url_for("vpn"))


@app.route("/vpn/add_peer", methods=["POST"])
@login_required
def vpn_add_peer():
    config = load_wg_config()
    if not config.get("server", {}).get("private_key"):
        flash("Initialize WireGuard server first.", "danger")
        return redirect(url_for("vpn"))
    name = request.form.get("name", "").strip()
    public_key = request.form.get("public_key", "").strip()
    allowed_ips = request.form.get("allowed_ips", "").strip()
    comment = request.form.get("comment", "").strip()
    if not name or not public_key or not allowed_ips:
        flash("Name, public key, and allowed IPs are required.", "danger")
        return redirect(url_for("vpn"))
    config["peers"].append({
        "name": name,
        "public_key": public_key,
        "allowed_ips": allowed_ips,
        "comment": comment,
    })
    save_wg_config(config)
    result = apply_wg(config)
    if result.returncode == 0:
        flash(f"Peer '{name}' added.", "success")
    else:
        flash(f"Peer saved but apply failed: {result.stderr}", "warning")
    return redirect(url_for("vpn"))


@app.route("/vpn/delete_peer", methods=["POST"])
@login_required
def vpn_delete_peer():
    idx = int(request.form["idx"])
    config = load_wg_config()
    peers = config.get("peers", [])
    if 0 <= idx < len(peers):
        removed = peers.pop(idx)
        save_wg_config(config)
        apply_wg(config)
        flash(f"Peer '{removed['name']}' removed.", "success")
    return redirect(url_for("vpn"))


@app.route("/vpn/client_config/<int:idx>")
@login_required
def vpn_client_config(idx):
    import re
    config = load_wg_config()
    server = config.get("server", {})
    peers = config.get("peers", [])
    if idx >= len(peers):
        flash("Peer not found.", "danger")
        return redirect(url_for("vpn"))
    peer = peers[idx]
    try:
        wan_info = subprocess.check_output(["ip", "-4", "addr", "show", "eth2"], text=True)
        match = re.search(r"inet (\d+\.\d+\.\d+\.\d+)", wan_info)
        endpoint = match.group(1) if match else "192.168.90.200"
    except Exception:
        endpoint = "192.168.90.200"
    client_conf = (
        f"# Client config for: {peer['name']}\n"
        f"# Run 'wg genkey | tee privkey | wg pubkey > pubkey' to generate your keys,\n"
        f"# then replace <your-private-key> below.\n\n"
        f"[Interface]\n"
        f"PrivateKey = <your-private-key>\n"
        f"Address = {peer['allowed_ips'].split(',')[0].strip()}\n"
        f"DNS = 192.168.95.200\n\n"
        f"[Peer]\n"
        f"PublicKey = {server['public_key']}\n"
        f"Endpoint = {endpoint}:{server.get('listen_port', 51820)}\n"
        f"AllowedIPs = 192.168.95.0/24, 192.168.90.0/24\n"
        f"PersistentKeepalive = 25\n"
    )
    from flask import Response
    return Response(
        client_conf,
        mimetype="text/plain",
        headers={"Content-Disposition": f"attachment; filename=wg0-{peer['name']}.conf"},
    )


@app.route("/api/vpn/status")
@login_required
def api_vpn_status():
    return jsonify({"up": wg_iface_up(), "peers": parse_wg_show()})


load_config()
_apply_rules_now(pending_rules)

_wg_startup = load_wg_config()
if _wg_startup.get("server", {}).get("private_key"):
    write_wg_conf(_wg_startup)
    subprocess.run(["wg-quick", "down", "wg0"], capture_output=True)
    subprocess.run(["wg-quick", "up", "wg0"], capture_output=True)
    _ensure_wg_masquerade()

app.run(host="0.0.0.0", port=5000)
