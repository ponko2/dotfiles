OS := $(shell uname -s)
SHELL := /bin/bash

LN := ln -sfnv
RM := rm -fv

SRCDIR := $(abspath home)
DOTFILES := $(foreach file, $(wildcard $(SRCDIR)/.??*), $(shell basename $(file)))

ifeq ($(OS),Darwin)
	ifeq ($(shell uname -m),arm64)
		HOMEBREW_PREFIX := /opt/homebrew
	else
		HOMEBREW_PREFIX := /usr/local
	endif
else
	HOMEBREW_PREFIX := /home/linuxbrew/.linuxbrew
endif

HOMEBREW := $(HOMEBREW_PREFIX)/bin/brew
HOMEBREW_BUNDLE := $(HOMEBREW_PREFIX)/Homebrew/Library/Taps/homebrew/homebrew-bundle

.DEFAULT_GOAL := help

.PHONY: all
all:

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: symlink bundle ## Run make symlink, bundle.

.PHONY: symlink
symlink: ## Create symlink to home directory.
	@$(foreach file, $(DOTFILES), $(LN) $(SRCDIR)/$(file) $(HOME)/$(file);)

.PHONY: bundle
bundle: | $(HOMEBREW) $(HOMEBREW_BUNDLE) ## Install and upgrade all dependencies from the ~/.Brewfile.
	$(SHELL) --login -c "brew bundle --global"
	$(HOMEBREW_PREFIX)/opt/fzf/install --all --xdg --no-update-rc

$(HOMEBREW):
	$(SHELL) -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$$($@ shellenv)"' >> $(HOME)/.profile

$(HOMEBREW_BUNDLE):
	$(SHELL) --login -c "brew tap homebrew/bundle"

.PHONY: update
update: ## Fetch changes for this repo.
	git pull origin main

.PHONY: clean
clean: ## Remove dotfiles.
	@$(foreach file, $(DOTFILES), $(RM) $(HOME)/$(file);)

.PHONY: neovim
neovim:
	pip3 install pynvim
	@nvim +CheckHealth

.PHONY: gruvbox
gruvbox: ## Clone gruvbox-contrib repository.
	ghq get morhetz/gruvbox-contrib

.PHONY: textlint
textlint: ## Install textlint.
	npm install -g textlint
	npm install -g textlint-rule-preset-japanese

.PHONY: zinit
zinit:
	sh -c "$$(curl -fsSL https://git.io/zinit-install)"
