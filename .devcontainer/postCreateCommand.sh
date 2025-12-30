#!/usr/bin/env bash

set -euo pipefail

ln -s /workspaces/dotfiles ~/dotfiles
nix run home-manager/master -- --flake ~/dotfiles -b backup switch

nix profile add nixpkgs#nix-direnv
mkdir -p ~/.config/direnv
echo "source ~/.nix-profile/share/nix-direnv/direnvrc" >> ~/.config/direnv/direnvrc

nix print-dev-env >/dev/null

direnv allow
