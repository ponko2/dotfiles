SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

export MISE_GLOBAL_CONFIG_FILE := $(HOME)/.dotfiles/home/.config/mise/config.toml
export MISE_TRUSTED_CONFIG_PATHS := $(HOME)/.dotfiles

# TODO: Remove this version pin once the fixes are included in the default installer release.
# ref: https://github.com/jdx/mise/pull/14570
# ref: https://github.com/jdx/mise/pull/14572
export MISE_VERSION := v2026.10.13

# TODO: Remove this workaround once the fix is released.
# ref: https://github.com/jdx/mise/pull/14596
export PATH := /nix/var/nix/profiles/default/bin:$(PATH)

MISE := $(shell command -v mise 2> /dev/null || echo $(HOME)/.local/bin/mise)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: install

$(MISE):
	curl -fsSL https://mise.run | sh

.PHONY: install
install: | $(MISE) ## Run mise bootstrap.
	$(MISE) -C ~/.dotfiles bootstrap --yes

.PHONY: test
test: ## Run checkmake.
	checkmake $(abspath $(firstword $(MAKEFILE_LIST)))
