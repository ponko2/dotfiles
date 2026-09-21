#!/usr/bin/env bash

set -euo pipefail

DOTFILES="$HOME/.dotfiles"

# Clone dotfiles repository.
if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/ponko2/dotfiles.git "$DOTFILES"
fi

make -C "$DOTFILES" clean all
