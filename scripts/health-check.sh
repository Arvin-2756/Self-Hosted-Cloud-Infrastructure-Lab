#!/usr/bin/env bash
set -euo pipefail

services=(
  "forgejo:192.168.1.201:3000"
  "nextcloud:192.168.1.202:80"
  "immich:192.168.1.203:2283"
  "adguard:192.168.1.204:3000"
  "nginx-proxy-manager:192.168.1.205:81"
)

failed=0
for service in "${services[@]}"; do
  IFS=: read -r name host port <<< "$service"
  if curl --fail --silent --show-error --connect-timeout 3 "http://${host}:${port}" >/dev/null; then
    printf 'PASS  %s (%s:%s)\n' "$name" "$host" "$port"
  else
    printf 'FAIL  %s (%s:%s)\n' "$name" "$host" "$port" >&2
    failed=1
  fi
done

exit "$failed"
