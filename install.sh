#!/bin/bash -u --

if [ -z "${SRCPATH:-}" ]; then
    SRCPATH="$HOME/src/github.com/ponko2/dotfiles"
fi

if [ ! -d "$SRCPATH" ]; then
  mkdir -p `dirname $SRCPATH` && cd $_
  git clone https://github.com/ponko2/dotfiles.git
fi

cd $SRCPATH && make install
