#!/bin/bash
set -e


# Default-deny forwarding; stateful rules applied by app.py on startup
iptables -P FORWARD DROP

# Ensure dnsmasq config files exist before supervisord starts dnsmasq
mkdir -p /etc/firewall /var/log/dnsmasq /var/log/arpmon /var/lib/arpmon
touch /etc/firewall/dns_hosts
[ -f /etc/firewall/dns_blocked.conf ] || touch /etc/firewall/dns_blocked.conf

# Show interfaces (for troubleshooting)
ip -c addr
ip route show

if getent hosts wazuh >/dev/null 2>&1; then
    /var/ossec/bin/wazuh-control start || true
else
    echo "[router] Wazuh not in DNS, skipping agent start"
fi

# Keep container running and provide a shell via exec
exec "$@"
