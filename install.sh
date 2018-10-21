#!/bin/bash -eux

if [ -z "${SRCPATH:-}" ]; then
  SRCPATH="$HOME/src/github.com/ponko2/dotfiles"
fi

if [ ! -d "$SRCPATH" ]; then
  mkdir -p "$(dirname "$SRCPATH")" && cd "$_" || exit 1
  git clone https://github.com/ponko2/dotfiles.git
fi

cd "$SRCPATH" && make install
