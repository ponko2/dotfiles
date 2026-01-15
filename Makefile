SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

XDG_BIN_HOME := $(HOME)/.local/bin
XDG_CONFIG_HOME := $(HOME)/.config
SRC_ROOT := $(abspath home)
DOTFILES := $(foreach path, $(filter-out $(SRC_ROOT)/.config $(SRC_ROOT)/.local, $(wildcard $(SRC_ROOT)/.??*)), $(HOME)/$(notdir $(path)))
XDG_BINS := $(foreach path, $(wildcard $(SRC_ROOT)/.local/bin/*), $(XDG_BIN_HOME)/$(notdir $(path)))
XDG_CONFIGS := $(foreach path, $(wildcard $(SRC_ROOT)/.config/*), $(XDG_CONFIG_HOME)/$(notdir $(path)))

ifeq ($(shell uname -s),Darwin)
	ifeq ($(shell uname -m),arm64)
		HOMEBREW_PREFIX := /opt/homebrew
	else
		HOMEBREW_PREFIX := /usr/local
	endif
else
	HOMEBREW_PREFIX := /home/linuxbrew/.linuxbrew
endif

HOMEBREW := $(HOMEBREW_PREFIX)/bin/brew

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: install

$(DOTFILES):
	ln -s $(SRC_ROOT)/$(@F) $@

$(XDG_BIN_HOME):
	mkdir -p $@

$(XDG_BINS): | $(XDG_BIN_HOME)
	ln -s $(SRC_ROOT)/.local/bin/$(@F) $@

$(XDG_CONFIG_HOME):
	mkdir -p $@

$(XDG_CONFIGS): | $(XDG_CONFIG_HOME)
	ln -s $(SRC_ROOT)/.config/$(@F) $@

.PHONY: symlink
symlink: | $(DOTFILES) $(XDG_BINS) $(XDG_CONFIGS) ## Create symlink to home directory.

$(HOMEBREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.ONESHELL: bundle
.PHONY: bundle
bundle: | $(HOMEBREW) ## Install and upgrade all dependencies from the ~/.config/homebrew/Brewfile.
	eval "$$($(HOMEBREW) shellenv)"
	XDG_CONFIG_HOME="$(XDG_CONFIG_HOME)" $(HOMEBREW) bundle --global

.PHONY: install
install: symlink bundle ## Run make symlink, bundle.

.PHONY: clean
clean: ## Remove symlinks.
	$(RM) $(DOTFILES) $(XDG_BINS) $(XDG_CONFIGS)

/nix:
	curl --proto '=https' --tlsv1.2 -fsSL https://artifacts.nixos.org/nix-installer | sh -s -- install --no-confirm

/etc/nix/nix.conf.before-nix-darwin:
	sudo mv /etc/nix/nix.conf $@

/etc/nix/nix.custom.conf.before-nix-darwin:
	sudo mv /etc/nix/nix.custom.conf $@

.ONESHELL: switch
.PHONY: switch
switch: | /nix /etc/nix/nix.conf.before-nix-darwin /etc/nix/nix.custom.conf.before-nix-darwin ## Build and switch to the new configuration.
	perl -i -pe "s/\"kano\"/\"$$(whoami)\"/g" flake.nix
	perl -i -pe "s/\"ponko2\"/\"$$(scutil --get LocalHostName)\"/g" flake.nix
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
	sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake ~/dotfiles

.PHONY: test
test: ## Run checkmake.
	checkmake Makefile
