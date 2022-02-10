#!/bin/bash

set -euo pipefail

if [ -z "${DOTFILES:-}" ]; then
  DOTFILES="$HOME/dotfiles"
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
  if [[ "$(uname -m)" == "arm64" ]]; then
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    HOMEBREW_PREFIX="/usr/local"
  fi
else
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# Clone dotfiles repository.
if [ ! -d "$DOTFILES" ]; then
  mkdir -p "$(dirname "$DOTFILES")"
  git clone https://github.com/ponko2/dotfiles.git "$DOTFILES"
fi

# Create symlink to home directory.
find "${DOTFILES}/home" -maxdepth 1 -name ".*" -print0 | while IFS= read -r -d '' src; do
  ln -sfnv "$src" "${HOME}/$(basename "$src")"
done

# Install Homebrew.
if [[ ! -x "${HOMEBREW_PREFIX}/bin/brew" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# Install Homebrew Bundle.
if [[ ! -d "${HOMEBREW_PREFIX}/Homebrew/Library/Taps/homebrew/homebrew-bundle" ]]; then
  brew tap homebrew/bundle
fi

# Install and upgrade all dependencies from the ~/.Brewfile.
brew bundle --global
"${HOMEBREW_PREFIX}/opt/fzf/install" --all --xdg --no-update-rc

# Clone gruvbox-contrib repository.
if command -v ghq >/dev/null; then
  ghq get morhetz/gruvbox-contrib
fi

# Install textlint.
if command -v npm >/dev/null; then
  npm install -g textlint
  npm install -g textlint-rule-preset-japanese
fi
