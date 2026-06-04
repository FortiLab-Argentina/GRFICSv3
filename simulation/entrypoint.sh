#!/bin/bash
set -e

# Detect interface by IP
IF=$(ip -o -4 addr show | awk '$4 ~ /^192\.168\.95\./ {print $2}' | head -n1)


echo "[entrypoint] Adding IP aliases to $IF manually..."

ip addr add 192.168.95.10/24 dev "$IF"
ip addr add 192.168.95.11/24 dev "$IF"
ip addr add 192.168.95.12/24 dev "$IF"
ip addr add 192.168.95.13/24 dev "$IF"
ip addr add 192.168.95.14/24 dev "$IF"
ip addr add 192.168.95.15/24 dev "$IF"

route add -net 192.168.90.0/24 gw 192.168.95.200

echo "[entrypoint] Starting nginx..."
# Give www-data access to the Docker socket so versions.php can query container labels.
# The socket GID varies by host, so we match it dynamically rather than hardcoding.
if [ -S /var/run/docker.sock ]; then
    DOCKER_GID=$(stat -c '%g' /var/run/docker.sock)
    groupadd -g "$DOCKER_GID" dockersock 2>/dev/null || true
    usermod -aG dockersock www-data
fi
php-fpm8.2 -D
nginx

echo "[entrypoint] Starting application..."
exec "$@"
