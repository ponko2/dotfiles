# Language
export LANG=ja_JP.UTF-8

# XDG Base Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# autoload
autoload -Uz add-zsh-hook
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
autoload -Uz colors && colors
autoload -Uz history-search-end
autoload -Uz is-at-least
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz smart-insert-last-word
autoload -Uz url-quote-magic
autoload -Uz zcalc
autoload -Uz zmv

# Editor
export EDITOR="vim --clean -c \"set cb+=unnamed\""
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"

# History
if [[ -d "/Volumes/GoogleDrive/マイドライブ/History" ]]; then
  export HISTFILE="/Volumes/GoogleDrive/マイドライブ/History/.zsh_history"
elif [[ -d "$HOME/Dropbox/History" ]]; then
  export HISTFILE="$HOME/Dropbox/History/.zsh_history"
else
  export HISTFILE="$HOME/.zsh_history"
fi
export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE='((cd|g[abcd]|gco|glo|gr|gsw|kill|ls|mv|rm|git (show|rebase -i|commit --fixup))( *)#|{*|exit|gss|pwd)'

# Correction
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude ".git" --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--ansi'
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --color=always . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --color=always . "$1"
}

setopt no_global_rcs

case ${OSTYPE} in
  darwin*)
    # MySQL
    export PATH=/usr/local/opt/mysql-client/bin:$PATH
    ;;
esac

# Node.js
export PATH=./node_modules/.bin:$PATH

# Golang
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH

# Rust
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
