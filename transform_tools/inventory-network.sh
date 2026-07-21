#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

OUTPUT_FILE="${1:-${PROJECT_ROOT}/network-inventory.txt}"

echo "GRFICSv3 Network Inventory" > "${OUTPUT_FILE}"
echo "Generated: $(date -Is)" >> "${OUTPUT_FILE}"
echo "========================================" >> "${OUTPUT_FILE}"
echo >> "${OUTPUT_FILE}"

IP_REGEX='([0-9]{1,3}\.){3}[0-9]{1,3}'

find "${PROJECT_ROOT}" \
    -path "${PROJECT_ROOT}/.git" -prune -o \
    -path "${PROJECT_ROOT}/.git/*" -prune -o \
    -path "${PROJECT_ROOT}/tools" -prune -o \
    -path "${PROJECT_ROOT}/tools/*" -prune -o \
    -type f -print0 |
while IFS= read -r -d '' file; do
    if file --brief --mime-type "${file}" 2>/dev/null | grep -q '^text/'; then
        matches="$(grep -nEo "${IP_REGEX}" "${file}" 2>/dev/null || true)"
        if [[ -n "${matches}" ]]; then
            {
                echo "FILE: ${file#${PROJECT_ROOT}/}"
                echo "${matches}"
                echo
            } >> "${OUTPUT_FILE}"
        fi
    fi
done

echo "Inventory written to: ${OUTPUT_FILE}"
