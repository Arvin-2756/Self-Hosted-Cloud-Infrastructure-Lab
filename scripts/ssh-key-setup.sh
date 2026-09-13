#!/usr/bin/env bash
set -euo pipefail

: "${KEY_PATH:=$HOME/.ssh/homelab_ed25519}"
if [[ -e "$KEY_PATH" ]]; then
  echo "SSH key already exists at $KEY_PATH"
else
  install -d -m 700 "$(dirname "$KEY_PATH")"
  ssh-keygen -t ed25519 -f "$KEY_PATH" -C "homelab-automation" -N ""
fi
printf 'Public key:\n'
cat "${KEY_PATH}.pub"
