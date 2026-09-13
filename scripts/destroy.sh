#!/usr/bin/env bash
set -euo pipefail

if [[ "${CONFIRM_DESTROY:-}" != "I_UNDERSTAND_THIS_DELETES_INFRASTRUCTURE" ]]; then
  echo "Refusing to destroy. Set CONFIRM_DESTROY to the exact confirmation phrase." >&2
  exit 1
fi

cd "$(dirname "${BASH_SOURCE[0]}")/../infrastructure"
: "${TOFU_BIN:=tofu}"
"$TOFU_BIN" destroy
