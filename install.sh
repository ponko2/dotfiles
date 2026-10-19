#!/usr/bin/env bash

set -euo pipefail

# TODO: Remove this version pin once the fixes are available in the default installer.
# ref: https://github.com/jdx/mise/pull/14596
export MISE_VERSION="v2026.10.14"

# Resolve mise executable.
MISE="$(command -v mise 2>/dev/null || echo "$HOME/.local/bin/mise")"

# Install mise if unavailable.
if [ ! -x "$MISE" ]; then
  curl -fsSL https://mise.run | sh
fi

if ! "$MISE" exec gh@latest -- gh auth status --active --hostname github.com >/dev/null 2>&1; then
  "$MISE" exec gh@latest -- gh auth login --hostname github.com --git-protocol https --web
fi

"$MISE" exec gh@latest -- gh auth setup-git --hostname github.com

"$MISE" bootstrap --adopt ponko2/dotfiles --yes
