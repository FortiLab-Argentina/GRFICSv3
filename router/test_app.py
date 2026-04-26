"""
Unit tests for router firewall rule generation, default configuration,
traffic stats helpers, and conntrack parsing.

Run with:  pytest router/test_app.py -v
"""
import os
import sys
import json
from io import StringIO
from unittest.mock import MagicMock, mock_open, patch

# app.py has module-level side effects: load_config(), subprocess.run(iptables-restore),
# and app.run() (blocking). Patch all of them before import so the module loads cleanly.
_open_mock = mock_open()
with patch("subprocess.run", return_value=MagicMock(returncode=0)), \
     patch("os.path.exists", return_value=False), \
     patch("os.makedirs"), \
     patch("builtins.open", _open_mock), \
     patch("flask.Flask.run"):
    sys.path.insert(0, os.path.dirname(__file__))
    import app as flask_app


# ---------------------------------------------------------------------------
# build_iptables_rules — pure function, no mocking needed
# ---------------------------------------------------------------------------

class TestForwardPolicy:
    def test_forward_chain_is_drop(self):
        result = flask_app.build_iptables_rules([])
        assert ":FORWARD DROP [0:0]" in result

    def test_forward_accept_policy_absent(self):
        result = flask_app.build_iptables_rules([])
        assert ":FORWARD ACCEPT" not in result


class TestConntrackBaseRules:
    def test_established_related_rule_present(self):
        result = flask_app.build_iptables_rules([])
        assert "-m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT" in result

    def test_invalid_drop_rule_present(self):
        result = flask_app.build_iptables_rules([])
        assert "-m conntrack --ctstate INVALID -j DROP" in result

    def test_conntrack_rules_precede_user_rules(self):
        rules = [{"proto": "tcp", "src": "192.168.90.0/24", "dst": "192.168.95.2",
                  "iface_in": "eth2", "iface_out": "", "dport": "502",
                  "action": "ACCEPT", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert result.index("ESTABLISHED,RELATED") < result.index("192.168.90.0/24"), \
            "Stateful conntrack rules must appear before user-defined rules"


class TestProtoHandling:
    def test_proto_all_omits_p_flag(self):
        rules = [{"proto": "all", "src": "10.0.0.1", "dst": "10.0.0.2",
                  "iface_in": "", "iface_out": "", "dport": "", "action": "ACCEPT", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert "-A FORWARD -s 10.0.0.1 -d 10.0.0.2 -j ACCEPT" in result
        # -p all must not appear
        user_lines = [l for l in result.splitlines()
                      if "10.0.0.1" in l or "10.0.0.2" in l]
        for line in user_lines:
            assert "-p all" not in line

    def test_proto_tcp_includes_p_flag(self):
        rules = [{"proto": "tcp", "src": "192.168.90.0/24", "dst": "192.168.95.2",
                  "iface_in": "eth2", "iface_out": "", "dport": "502",
                  "action": "ACCEPT", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert "-A FORWARD -p tcp -s 192.168.90.0/24 -d 192.168.95.2 -i eth2 --dport 502 -j ACCEPT" in result

    def test_dport_skipped_for_icmp(self):
        rules = [{"proto": "icmp", "src": "0.0.0.0/0", "dst": "0.0.0.0/0",
                  "iface_in": "", "iface_out": "", "dport": "8080",
                  "action": "ACCEPT", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert "--dport" not in result

    def test_dport_skipped_for_proto_all(self):
        rules = [{"proto": "all", "src": "0.0.0.0/0", "dst": "0.0.0.0/0",
                  "iface_in": "", "iface_out": "", "dport": "443",
                  "action": "ACCEPT", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert "--dport" not in result


class TestActionHandling:
    def test_drop_routes_to_logdrop(self):
        rules = [{"proto": "tcp", "src": "0.0.0.0/0", "dst": "0.0.0.0/0",
                  "iface_in": "", "iface_out": "", "dport": "", "action": "DROP", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert "-j LOGDROP" in result

    def test_reject_routes_to_logreject(self):
        rules = [{"proto": "tcp", "src": "0.0.0.0/0", "dst": "0.0.0.0/0",
                  "iface_in": "", "iface_out": "", "dport": "", "action": "REJECT", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert "-j LOGREJECT" in result

    def test_accept_uses_accept_directly(self):
        rules = [{"proto": "tcp", "src": "0.0.0.0/0", "dst": "0.0.0.0/0",
                  "iface_in": "", "iface_out": "", "dport": "", "action": "ACCEPT", "comment": ""}]
        result = flask_app.build_iptables_rules(rules)
        assert "-j ACCEPT" in result
        assert "LOGACCEPT" not in result


class TestCommentHandling:
    def test_comment_absent_from_iptables_output(self):
        rules = [{"proto": "all", "src": "0.0.0.0/0", "dst": "0.0.0.0/0",
                  "iface_in": "", "iface_out": "", "dport": "", "action": "ACCEPT",
                  "comment": "TEMP - allow all traffic for troubleshooting - DO NOT LEAVE IN PRODUCTION"}]
        result = flask_app.build_iptables_rules(rules)
        assert "TEMP" not in result
        assert "troubleshooting" not in result
        assert "PRODUCTION" not in result


class TestOutputStructure:
    def test_starts_with_filter_table(self):
        result = flask_app.build_iptables_rules([])
        assert result.startswith("*filter")

    def test_ends_with_commit(self):
        result = flask_app.build_iptables_rules([])
        assert result.strip().endswith("COMMIT")


# ---------------------------------------------------------------------------
# DEFAULT_RULES — misconfiguration scenario
# ---------------------------------------------------------------------------

class TestDefaultRules:
    def test_exactly_one_default_rule(self):
        assert len(flask_app.DEFAULT_RULES) == 1

    def test_default_rule_is_allow_any(self):
        rule = flask_app.DEFAULT_RULES[0]
        assert rule["action"] == "ACCEPT"
        assert rule["src"] == "0.0.0.0/0"
        assert rule["dst"] == "0.0.0.0/0"
        assert rule["proto"] == "all"

    def test_default_rule_has_no_interface_restriction(self):
        rule = flask_app.DEFAULT_RULES[0]
        assert rule["iface_in"] == ""
        assert rule["iface_out"] == ""

    def test_default_rule_has_descriptive_comment(self):
        rule = flask_app.DEFAULT_RULES[0]
        assert rule.get("comment"), "Default allow-any rule must carry a warning comment"

    def test_default_rule_produces_allow_any_iptables_line(self):
        result = flask_app.build_iptables_rules(flask_app.DEFAULT_RULES)
        assert "-A FORWARD -s 0.0.0.0/0 -d 0.0.0.0/0 -j ACCEPT" in result

    def test_default_rule_combined_with_default_deny_policy(self):
        # Even with the allow-any user rule, the policy header must still be DROP
        result = flask_app.build_iptables_rules(flask_app.DEFAULT_RULES)
        assert ":FORWARD DROP [0:0]" in result


# ---------------------------------------------------------------------------
# parse_conntrack — /proc/net/nf_conntrack parsing
# ---------------------------------------------------------------------------

SAMPLE_CONNTRACK = """\
ipv4     2 tcp      6 86393 ESTABLISHED src=192.168.95.2 dst=192.168.90.107 sport=49832 dport=8080 src=192.168.90.107 dst=192.168.95.2 sport=8080 dport=49832 [ASSURED] mark=0 zone=0 use=2
ipv4     2 udp      17 25 src=192.168.95.5 dst=8.8.8.8 sport=54321 dport=53 [UNREPLIED] src=8.8.8.8 dst=192.168.95.5 sport=53 dport=54321 mark=0 zone=0 use=1
ipv4     2 icmp     1 29 src=192.168.90.6 dst=192.168.95.2 type=8 code=0 id=1234 src=192.168.95.2 dst=192.168.90.6 type=0 code=0 id=1234 mark=0 zone=0 use=1
"""


class TestParseConntrack:
    def _parse(self, content=SAMPLE_CONNTRACK):
        with patch("builtins.open", mock_open(read_data=content)):
            return flask_app.parse_conntrack()

    def test_returns_correct_count(self):
        entries = self._parse()
        assert len(entries) == 3

    def test_tcp_entry_fields(self):
        entries = self._parse()
        tcp = next(e for e in entries if e['proto'] == 'tcp')
        assert tcp['state'] == 'ESTABLISHED'
        assert tcp['src'] == '192.168.95.2'
        assert tcp['dst'] == '192.168.90.107'
        assert tcp['sport'] == '49832'
        assert tcp['dport'] == '8080'
        assert tcp['ttl'] == 86393

    def test_udp_entry_has_no_state(self):
        entries = self._parse()
        udp = next(e for e in entries if e['proto'] == 'udp')
        assert udp['state'] == ''
        assert udp['src'] == '192.168.95.5'
        assert udp['dport'] == '53'

    def test_icmp_entry_parsed(self):
        entries = self._parse()
        icmp = next(e for e in entries if e['proto'] == 'icmp')
        assert icmp['src'] == '192.168.90.6'
        assert icmp['dst'] == '192.168.95.2'

    def test_original_direction_used_not_reply(self):
        # The reply direction has swapped src/dst — we must use the original
        entries = self._parse()
        tcp = next(e for e in entries if e['proto'] == 'tcp')
        assert tcp['src'] == '192.168.95.2'   # original src, not reply src (192.168.90.107)
        assert tcp['dst'] == '192.168.90.107'

    def test_missing_file_returns_empty(self):
        with patch("builtins.open", side_effect=FileNotFoundError):
            entries = flask_app.parse_conntrack()
        assert entries == []

    def test_empty_file_returns_empty(self):
        entries = self._parse("")
        assert entries == []


# ---------------------------------------------------------------------------
# get_top_talkers
# ---------------------------------------------------------------------------

class TestGetTopTalkers:
    def _entries(self, ips):
        return [{'src': ip, 'proto': 'tcp', 'dst': '1.2.3.4',
                 'sport': '1', 'dport': '80', 'state': '', 'ttl': 100}
                for ip in ips]

    def test_counts_correctly(self):
        entries = self._entries(['10.0.0.1', '10.0.0.1', '10.0.0.2'])
        result = flask_app.get_top_talkers(entries)
        assert result[0] == {'ip': '10.0.0.1', 'connections': 2}
        assert result[1] == {'ip': '10.0.0.2', 'connections': 1}

    def test_respects_n_limit(self):
        entries = self._entries([f'10.0.0.{i}' for i in range(20)])
        result = flask_app.get_top_talkers(entries, n=5)
        assert len(result) == 5

    def test_unknown_src_excluded(self):
        entries = self._entries(['10.0.0.1', '?', '?'])
        result = flask_app.get_top_talkers(entries)
        assert all(t['ip'] != '?' for t in result)

    def test_empty_input(self):
        assert flask_app.get_top_talkers([]) == []


# ---------------------------------------------------------------------------
# read_proc_net_dev
# ---------------------------------------------------------------------------

SAMPLE_PROC_NET_DEV = """\
Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
    lo:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
  eth0:    1000     100    0    0    0     0          0         0     2000     200    0    0    0     0       0          0
  eth1:    3000     300    0    0    0     0          0         0     4000     400    0    0    0     0       0          0
  eth2:    5000     500    0    0    0     0          0         0     6000     600    0    0    0     0       0          0
"""


class TestReadProcNetDev:
    def test_parses_all_interfaces(self):
        with patch("builtins.open", mock_open(read_data=SAMPLE_PROC_NET_DEV)):
            stats = flask_app.read_proc_net_dev()
        assert set(stats.keys()) >= {'eth0', 'eth1', 'eth2'}

    def test_correct_byte_counts(self):
        with patch("builtins.open", mock_open(read_data=SAMPLE_PROC_NET_DEV)):
            stats = flask_app.read_proc_net_dev()
        assert stats['eth1']['rx_bytes'] == 3000
        assert stats['eth1']['tx_bytes'] == 4000
        assert stats['eth2']['rx_packets'] == 500

    def test_missing_file_returns_empty(self):
        with patch("builtins.open", side_effect=FileNotFoundError):
            stats = flask_app.read_proc_net_dev()
        assert stats == {}


# ---------------------------------------------------------------------------
# api_stats / api_states — route response shape
# ---------------------------------------------------------------------------

class TestApiRoutes:
    def setup_method(self):
        flask_app.app.config['TESTING'] = True
        flask_app.app.config['SECRET_KEY'] = 'test'
        self.client = flask_app.app.test_client()
        # Establish a session so login_required passes
        with self.client.session_transaction() as sess:
            sess['logged_in'] = True
            sess['username'] = 'admin'

    def test_api_stats_returns_json(self):
        with patch.object(flask_app, 'parse_conntrack', return_value=[]), \
             patch.object(flask_app, 'get_interface_rates', return_value={
                 'eth0': {'rx_bps': 0.0, 'rx_pps': 0.0, 'tx_bps': 0.0, 'tx_pps': 0.0},
                 'eth1': {'rx_bps': 0.0, 'rx_pps': 0.0, 'tx_bps': 0.0, 'tx_pps': 0.0},
                 'eth2': {'rx_bps': 0.0, 'rx_pps': 0.0, 'tx_bps': 0.0, 'tx_pps': 0.0},
             }):
            resp = self.client.get('/api/stats')
        assert resp.status_code == 200
        data = json.loads(resp.data)
        assert 'connection_count' in data
        assert 'interfaces' in data
        assert 'top_talkers' in data

    def test_api_stats_connection_count(self):
        fake_entries = [
            {'proto': 'tcp', 'state': 'ESTABLISHED', 'src': '192.168.95.2',
             'dst': '192.168.90.107', 'sport': '1234', 'dport': '80', 'ttl': 300},
        ]
        with patch.object(flask_app, 'parse_conntrack', return_value=fake_entries), \
             patch.object(flask_app, 'get_interface_rates', return_value={}):
            resp = self.client.get('/api/stats')
        data = json.loads(resp.data)
        assert data['connection_count'] == 1

    def test_api_states_returns_json(self):
        with patch.object(flask_app, 'parse_conntrack', return_value=[]):
            resp = self.client.get('/api/states')
        assert resp.status_code == 200
        data = json.loads(resp.data)
        assert 'states' in data
        assert 'count' in data

    def test_api_states_count_matches_list(self):
        fake_entries = [
            {'proto': 'udp', 'state': '', 'src': '10.0.0.1', 'dst': '8.8.8.8',
             'sport': '9999', 'dport': '53', 'ttl': 30},
            {'proto': 'tcp', 'state': 'ESTABLISHED', 'src': '10.0.0.2', 'dst': '10.0.0.3',
             'sport': '443', 'dport': '50000', 'ttl': 300},
        ]
        with patch.object(flask_app, 'parse_conntrack', return_value=fake_entries):
            resp = self.client.get('/api/states')
        data = json.loads(resp.data)
        assert data['count'] == 2
        assert len(data['states']) == 2

    def test_api_requires_login(self):
        # Fresh client with no session
        anon = flask_app.app.test_client()
        resp = anon.get('/api/stats')
        assert resp.status_code == 302  # redirect to login
