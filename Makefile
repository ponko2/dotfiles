SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

export XDG_BIN_HOME := $(HOME)/.local/bin
export XDG_CONFIG_HOME := $(HOME)/.config
export MISE_GLOBAL_CONFIG_FILE := $(HOME)/.dotfiles/home/.config/mise/config.toml

ifeq ($(shell uname -s),Darwin)
	ifeq ($(shell uname -m),arm64)
		HOMEBREW := /opt/homebrew/bin/brew
	else
		HOMEBREW := /usr/local/bin/brew
	endif
else
	HOMEBREW := /home/linuxbrew/.linuxbrew/bin/brew
endif

MISE := $(shell command -v mise 2> /dev/null || echo $(HOME)/.local/bin/mise)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: install

$(XDG_BIN_HOME):
	mkdir -p $@

$(XDG_CONFIG_HOME):
	mkdir -p $@

$(MISE):
	curl -fsSL https://mise.run | sh

.PHONY: bootstrap
bootstrap: | $(MISE) ## Run mise bootstrap.
	$(MISE) bootstrap --yes -C ~/.dotfiles

.PHONY: symlink
symlink: | $(MISE) ## Create symlink to home directory.
	$(MISE) bootstrap dotfiles apply

$(HOMEBREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.ONESHELL: bundle
.PHONY: bundle
bundle: | $(HOMEBREW) ## Install and upgrade all dependencies from the ~/.config/homebrew/Brewfile.
	eval "$$($(HOMEBREW) shellenv)"
	$(HOMEBREW) bundle --global

.PHONY: install
install: bootstrap bundle ## Run make bootstrap, bundle.

.PHONY: clean
clean: | $(MISE) ## Remove symlinks.
	$(MISE) bootstrap dotfiles unapply

/nix:
	curl -fsSL https://artifacts.nixos.org/nix-installer | sh -s -- install --no-confirm

.PHONY: switch
switch: | /nix ## Build and switch to the new configuration.
	perl -i -pe "s/\"kano\"/\"$$(whoami)\"/g" ~/.dotfiles/flake.nix
	perl -i -pe "s/\"ponko2\"/\"$$(scutil --get LocalHostName)\"/g" ~/.dotfiles/flake.nix
	perl -i -pe "s/uid = \d+;/uid = $$(id -u);/g" ~/.dotfiles/flake.nix
	sudo /nix/var/nix/profiles/default/bin/nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles

.PHONY: test
test: ## Run checkmake.
	checkmake $(abspath $(firstword $(MAKEFILE_LIST)))
