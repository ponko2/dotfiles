#!/bin/bash

set -euo pipefail

if [ -z "${DOTFILES:-}" ]; then
  DOTFILES="$HOME/dotfiles"
fi

# Clone dotfiles repository.
if [ ! -d "$DOTFILES" ]; then
  mkdir -p "$(dirname "$DOTFILES")"
  git clone https://github.com/ponko2/dotfiles.git "$DOTFILES"
fi

cd "$DOTFILES" && make install
