SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

export MISE_GLOBAL_CONFIG_FILE := $(HOME)/.dotfiles/home/.config/mise/config.toml
export MISE_TRUSTED_CONFIG_PATHS := $(HOME)/.dotfiles

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
