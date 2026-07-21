#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CONFIG_DIR="${PROJECT_ROOT}/config"

source "${CONFIG_DIR}/network.env"
source "${CONFIG_DIR}/components.env"

log()  { printf '[INFO] %s\n' "$*"; }
ok()   { printf '[OK] %s\n' "$*"; }
warn() { printf '[WARN] %s\n' "$*" >&2; }
error(){ printf '[ERROR] %s\n' "$*" >&2; }

component_to_zone() {
    case "$1" in
        SIMULATOR) echo "${SIMULATOR_ZONE}" ;;
        PLC)       echo "${PLC_ZONE}" ;;
        HMI)       echo "${HMI_ZONE}" ;;
        CALDERA)   echo "${CALDERA_ZONE}" ;;
        *) error "Unknown component: $1"; return 1 ;;
    esac
}

zone_to_gateway() {
    case "$1" in
        FEED)         echo "${FEED_GATEWAY}" ;;
        PLC)          echo "${PLC_GATEWAY}" ;;
        HMI_CALDERA)  echo "${HMI_CALDERA_GATEWAY}" ;;
        *) error "Unknown zone: $1"; return 1 ;;
    esac
}
