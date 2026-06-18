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
    # A group with this GID may already exist (e.g. 'docker' on a fresh Ubuntu install).
    # If so, reuse it rather than trying to create 'dockersock', which would fail and
    # leave no group for the subsequent usermod call.
    DOCKER_GROUP=$(getent group "$DOCKER_GID" | cut -d: -f1)
    if [ -z "$DOCKER_GROUP" ]; then
        groupadd -g "$DOCKER_GID" dockersock
        DOCKER_GROUP=dockersock
    fi
    usermod -aG "$DOCKER_GROUP" www-data
fi
php-fpm8.2 -D
nginx

echo "[entrypoint] Starting application..."
exec "$@"
