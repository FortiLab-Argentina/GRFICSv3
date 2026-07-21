#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

IP_MAP="${CONFIG_DIR}/ip-map.env"
GATEWAY_MAP="${CONFIG_DIR}/gateway-map.env"

usage() {
    echo "Usage:"
    echo "  $0 --component COMPONENT --path PATH"
    echo
    echo "Examples:"
    echo "  $0 --component PLC --path plc/"
    echo "  $0 --component SIMULATOR --path simulation/"
    echo "  $0 --component HMI --path hmi/"
}

COMPONENT=""
TARGET_PATH=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --component)
            COMPONENT="$2"
            shift 2
            ;;
        --path)
            TARGET_PATH="$2"
            shift 2
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

if [[ -z "${COMPONENT}" || -z "${TARGET_PATH}" ]]; then
    usage
    exit 1
fi

TARGET_PATH="${PROJECT_ROOT}/${TARGET_PATH}"
ZONE="$(component_to_zone "${COMPONENT}")"
NEW_GATEWAY="$(zone_to_gateway "${ZONE}")"

echo "========================================"
echo "Contextual Network Transformation"
echo "========================================"
echo "Component : ${COMPONENT}"
echo "Zone      : ${ZONE}"
echo "Gateway   : ${NEW_GATEWAY}"
echo "Path      : ${TARGET_PATH}"
echo

if [[ ! -d "${TARGET_PATH}" && ! -f "${TARGET_PATH}" ]]; then
    error "Target path does not exist: ${TARGET_PATH}"
    exit 1
fi

replace_in_path() {
    local old="$1"
    local new="$2"

    while IFS= read -r -d '' file; do
        if file --brief --mime-type "${file}" 2>/dev/null | grep -q '^text/'; then
            if grep -qF -- "${old}" "${file}" 2>/dev/null; then
                sed -i "s/${old//./\.}/${new}/g" "${file}"
                echo "  ${file#${PROJECT_ROOT}/}: ${old} -> ${new}"
            fi
        fi
    done < <(
        if [[ -d "${TARGET_PATH}" ]]; then
            find "${TARGET_PATH}" -type f -print0
        else
            printf '%s\0' "${TARGET_PATH}"
        fi
    )
}

# Device IP mapping for the selected component.
while IFS='|' read -r map_component old_ip new_ip description; do
    [[ -z "${map_component:-}" ]] && continue
    [[ "${map_component}" =~ ^[[:space:]]*# ]] && continue

    if [[ "${map_component}" == "${COMPONENT}" ]]; then
        echo "Applying device IP mapping:"
        replace_in_path "${old_ip}" "${new_ip}"
    fi
done < "${IP_MAP}"

echo
echo "Applying contextual gateway mapping:"

found_gateway=0
while IFS='|' read -r map_component old_gateway mapped_gateway description; do
    [[ -z "${map_component:-}" ]] && continue
    [[ "${map_component}" =~ ^[[:space:]]*# ]] && continue

    if [[ "${map_component}" == "${COMPONENT}" ]]; then
        found_gateway=1
        # The target gateway is resolved from the component's Purdue zone.
        replace_in_path "${old_gateway}" "${NEW_GATEWAY}"
    fi
done < "${GATEWAY_MAP}"

if [[ "${found_gateway}" -eq 0 ]]; then
    warn "No gateway mapping found for component ${COMPONENT}"
fi

echo
ok "Transformation completed for ${COMPONENT}"
echo "Run verify-network.sh after all components are transformed."
