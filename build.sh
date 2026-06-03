#!/usr/bin/env bash
set -e
export BUILD_VERSION=$(git describe --tags --always --dirty 2>/dev/null || git rev-parse --short HEAD)
export BUILD_CREATED=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "Building GRFICSv3 — version: $BUILD_VERSION  created: $BUILD_CREATED"
docker compose build "$@"
