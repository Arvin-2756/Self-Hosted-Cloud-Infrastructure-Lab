#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/../infrastructure"
: "${TOFU_BIN:=tofu}"
command -v "$TOFU_BIN" >/dev/null || { echo "OpenTofu is required: $TOFU_BIN not found" >&2; exit 1; }

"$TOFU_BIN" init
