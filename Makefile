SHELL := /bin/zsh
.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

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

.PHONY: all
all: install

.PHONY: clean
clean: ## Remove symlink.
	sudo $(RM) /etc/nix-darwin/flake.nix

.PHONY: test
test: ## Run checkmake.
	checkmake Makefile

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

/etc/nix-darwin/flake.nix:
	sudo mkdir -p $(@D)
	sudo ln -s $(abspath $(@F)) $@

.PHONY: symlink
symlink: | /etc/nix-darwin/flake.nix ## Create symlink.

/nix:
	curl -fsSL https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix

$(HOMEBREW):
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

.PHONY: switch
switch: | /nix $(HOMEBREW) ## Build and switch to the new configuration.
	$(SHELL) -ic "sudo nix run nix-darwin/master#darwin-rebuild -- switch"

.PHONY: install
install: symlink switch ## Run make symlink, switch.
