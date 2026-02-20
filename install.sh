#!/usr/bin/env bash

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

make_targets=(clean all)

for arg in "$@"; do
  case "$arg" in
    --use-nix)
      make_targets=(switch)
      ;;
    *)
      echo "Unknown option: $arg" >&2
      echo "Usage: $0 [--use-nix]" >&2
      exit 1
      ;;
  esac
done

# Clone dotfiles repository.
if [ ! -d "$DOTFILES" ]; then
  mkdir -p "$(dirname "$DOTFILES")"
  git clone https://github.com/ponko2/dotfiles.git "$DOTFILES"
fi

make -C "$DOTFILES" "${make_targets[@]}"
