# dotfiles

[![CI](https://github.com/ponko2/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/ponko2/dotfiles/actions/workflows/ci.yml)
[![CodeQL](https://github.com/ponko2/dotfiles/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/ponko2/dotfiles/actions/workflows/github-code-scanning/codeql)

## Install

### Using [Homebrew](https://brew.sh)

#### Step 1: Install [Xcode Command Line Tools](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools)

```sh
xcode-select --install
```

#### Step 2: Run the dotfiles installer

```sh
curl -fsSL https://raw.githubusercontent.com/ponko2/dotfiles/HEAD/install.sh | /bin/bash
```

### Using [Nix](https://nixos.org)

#### Step 1: Install [Xcode Command Line Tools](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools)

```sh
xcode-select --install
```

#### Step 2: Build and switch to the [nix-darwin](https://nix-darwin.org) configuration

```sh
curl -fsSL https://raw.githubusercontent.com/ponko2/dotfiles/HEAD/install.sh | /bin/bash -s -- --use-nix
```
