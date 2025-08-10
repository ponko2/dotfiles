# in ~/.zshenv, executed `unsetopt GLOBAL_RCS` and ignored /etc/zshrc
if [[ -r /etc/zshrc ]]; then
  source /etc/zshrc
fi

umask 022

if [ "$TERM" != 'dumb' ]; then
  stty -ixon -ixoff
fi

# Language
export LANG=ja_JP.UTF-8

# XDG Base Directory
export XDG_BIN_HOME=$HOME/.local/bin
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Correction
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

# Editor
export EDITOR="nvim --clean -c 'set enc=utf-8 cb+=unnamed'"
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"

# History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE='(* --help|(bat|cat|cd|chmod|chown|cp|echo|ls|man|mv|rm|which)(| *)|git (add|blame|checkout|cherry-pick|commit|diff|log|rebase|reset|revert|show|status) *|{*)'
if [[ -d "$XDG_STATE_HOME/zsh" ]]; then
  export HISTFILE="$XDG_STATE_HOME/zsh/history"
else
  export HISTFILE=~/.zsh_history
fi

# Golang
export GOBIN="$XDG_BIN_HOME"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export GOPATH="$XDG_DATA_HOME/go"

# Rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

path=(
  ./node_modules/.bin # Node.js
  "$XDG_BIN_HOME"(N-/)
  "$HOMEBREW_PREFIX/opt/mysql-client/bin"(N-/) # MySQL Client
  "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"(N-/) # coreutils
  "$HOMEBREW_PREFIX/opt/ed/libexec/gnubin"(N-/) # ed
  "$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin"(N-/) # findutils
  "$HOMEBREW_PREFIX/opt/gawk/libexec/gnubin"(N-/) # awk
  "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin"(N-/) # sed
  "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin"(N-/) # tar
  "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"(N-/) # grep
  $path
)

manpath=(
  "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnuman"(N-/) # coreutils
  "$HOMEBREW_PREFIX/opt/ed/libexec/gnuman"(N-/) # ed
  "$HOMEBREW_PREFIX/opt/findutils/libexec/gnuman"(N-/) # findutils
  "$HOMEBREW_PREFIX/opt/gawk/libexec/gnuman"(N-/) # awk
  "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman"(N-/) # sed
  "$HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnuman"(N-/) # tar
  "$HOMEBREW_PREFIX/opt/grep/libexec/gnuman"(N-/) # grep
  $manpath
)

# Use emacs key bindings
bindkey -e

if command -v sheldon >/dev/null; then
  eval "$(sheldon source)"
fi
