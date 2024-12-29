SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c
.DEFAULT_GOAL := help

XDG_BIN_HOME := $(HOME)/.local/bin
XDG_CONFIG_HOME := $(HOME)/.config
SRCDIR := $(abspath home)
DOTFILES := $(foreach path, $(wildcard $(SRCDIR)/.??*), $(HOME)/$(notdir $(path)))
XDG_BINS := $(foreach path, $(wildcard $(SRCDIR)/.local/bin/*), $(XDG_BIN_HOME)/$(notdir $(path)))
XDG_CONFIGS := $(foreach path, $(wildcard $(SRCDIR)/_config/*), $(XDG_CONFIG_HOME)/$(notdir $(path)))

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
HOMEBREW_BUNDLE := $(HOMEBREW_PREFIX)/Homebrew/Library/Taps/homebrew/homebrew-bundle

.PHONY: all
all: install

.PHONY: clean
clean: ## Remove symlinks.
	$(RM) $(DOTFILES) $(XDG_CONFIGS)

.PHONY: test
test: ## Run checkmake.
	checkmake Makefile

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: symlink bundle ## Run make symlink, bundle.

.PHONY: symlink
symlink: | $(DOTFILES) $(XDG_BINS) $(XDG_CONFIGS) ## Create symlink to home directory.

$(DOTFILES):
	ln -s $(SRCDIR)/$(@F) $@

$(XDG_BINS): | $(XDG_BIN_HOME)
	ln -s $(SRCDIR)/.local/bin/$(@F) $@

$(XDG_CONFIGS): | $(XDG_CONFIG_HOME)
	ln -s $(SRCDIR)/_config/$(@F) $@

$(XDG_BIN_HOME):
	mkdir -p $@

$(XDG_CONFIG_HOME):
	mkdir $@

.PHONY: bundle
bundle: | $(HOMEBREW) $(HOMEBREW_BUNDLE) ## Install and upgrade all dependencies from the ~/.Brewfile.
	$(SHELL) --login -c "brew bundle --global"
	$(HOMEBREW_PREFIX)/opt/fzf/install --all --xdg --no-update-rc

$(HOMEBREW):
	NONINTERACTIVE=1 $(SHELL) -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	printf '\neval "$$($@ shellenv)"' >> $(HOME)/.profile

$(HOMEBREW_BUNDLE):
	$(SHELL) --login -c "brew tap homebrew/bundle"
