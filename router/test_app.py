"""
Unit tests for router firewall rule generation and default configuration.

Run with:  pytest router/test_app.py -v
"""
import os
import sys
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
