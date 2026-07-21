#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

FAILED=0

echo "========================================"
echo "GRFICSv3 Contextual Network Validation"
echo "========================================"
echo

python3 - <<'PY'
import ipaddress
import os
import sys

networks = {
    "FEED": ipaddress.ip_network(os.environ["FEED_NETWORK"]),
    "PLC": ipaddress.ip_network(os.environ["PLC_NETWORK"]),
    "HMI_CALDERA": ipaddress.ip_network(os.environ["HMI_CALDERA_NETWORK"]),
}

gateways = {
    "FEED": ipaddress.ip_address(os.environ["FEED_GATEWAY"]),
    "PLC": ipaddress.ip_address(os.environ["PLC_GATEWAY"]),
    "HMI_CALDERA": ipaddress.ip_address(os.environ["HMI_CALDERA_GATEWAY"]),
}

failed = False

for name, net in networks.items():
    print(f"[OK] {name} network: {net}")

items = list(networks.items())
for i, (name_a, net_a) in enumerate(items):
    for name_b, net_b in items[i+1:]:
        if net_a.overlaps(net_b):
            print(f"[ERROR] Overlapping networks: {name_a} and {name_b}")
            failed = True

for zone, gateway in gateways.items():
    if gateway not in networks[zone]:
        print(f"[ERROR] Gateway {gateway} is outside {zone} network")
        failed = True
    else:
        print(f"[OK] {zone} gateway: {gateway}")

sys.exit(1 if failed else 0)
PY

echo
echo "Checking contextual gateway mappings..."

while IFS='|' read -r component old_gateway new_gateway description; do
    [[ -z "${component:-}" ]] && continue
    [[ "${component}" =~ ^[[:space:]]*# ]] && continue

    zone="$(component_to_zone "${component}")"
    expected_gateway="$(zone_to_gateway "${zone}")"

    if [[ "${new_gateway}" != "${expected_gateway}" ]]; then
        echo "[ERROR] ${component}: mapping gateway ${new_gateway} does not match expected ${expected_gateway}"
        FAILED=1
    else
        echo "[OK] ${component}: ${zone} -> ${expected_gateway}"
    fi
done < "${CONFIG_DIR}/gateway-map.env"

echo
if [[ "${FAILED}" -eq 0 ]]; then
    ok "Network validation passed"
else
    error "Network validation failed"
    exit 1
fi
