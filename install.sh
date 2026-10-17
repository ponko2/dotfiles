#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/.dotfiles"

export MISE_GLOBAL_CONFIG_FILE="$DOTFILES/home/.config/mise/config.toml"
export MISE_TRUSTED_CONFIG_PATHS="$DOTFILES"

# TODO: Remove this version pin once the fixes are included in the default installer release.
# ref: https://github.com/jdx/mise/pull/14570
# ref: https://github.com/jdx/mise/pull/14572
export MISE_VERSION="v2026.10.13"

# TODO: Remove this workaround once the fix is released.
# ref: https://github.com/jdx/mise/pull/14596
export PATH="/nix/var/nix/profiles/default/bin:$PATH"

# Clone dotfiles repository.
if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/ponko2/dotfiles.git "$DOTFILES"
fi

# Resolve mise executable.
MISE="$(command -v mise 2>/dev/null || echo "$HOME/.local/bin/mise")"

# Install mise if unavailable.
if [ ! -x "$MISE" ]; then
  curl -fsSL https://mise.run | sh
fi

"$MISE" -C "$DOTFILES" bootstrap --yes
