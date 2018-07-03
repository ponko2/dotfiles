OS       := $(shell uname -s)
SHELL    := /bin/bash
SRCDIR   := $(abspath home)
DOTFILES := $(foreach file, $(wildcard $(SRCDIR)/.??*), $(shell basename $(file)))

LN := ln -sfnv
RM := rm -fv

.DEFAULT_GOAL := help

ifeq ($(OS),Darwin)
	HOMEBREW := /usr/local/bin/brew
endif

all:

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

$(HOMEBREW):
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew tap Homebrew/bundle
	brew bundle

init: | $(HOMEBREW) ## Setup dotfiles

deploy: ## Create symlink to home directory
	@$(foreach file, $(DOTFILES), $(LN) $(SRCDIR)/$(file) $(HOME)/$(file);)

update: ## Fetch changes for this repo
	git pull origin master

clean: ## Remove dotfiles
	@$(foreach file, $(DOTFILES), $(RM) $(HOME)/$(file);)

neovim:
	pip2 install neovim
	pip3 install neovim
	pip3 install neovim-remote
	gem install neovim
	@nvim +CheckHealth

gruvbox:
	ghq get morhetz/gruvbox-contrib

textlint:
	npm install -g textlint textlint-rule-preset-japanese

.PHONY: install
install: init deploy ## Run make init, deploy
