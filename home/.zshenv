# Language
export LANG=ja_JP.UTF-8

# XDG Base Directory
export XDG_BIN_HOME=$HOME/.local/bin
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# Editor
export EDITOR="vim --clean -c \"set enc=utf-8 cb+=unnamed\""
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"

# History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE='(* --help|(bat|cat|cd|chmod|chown|cp|echo|ls|man|mv|rm|which)(| *)|git (add|blame|checkout|cherry-pick|commit|diff|log|rebase|reset|revert|show|status) *|{*)'

# Correction
export CORRECT_IGNORE='_*'
export CORRECT_IGNORE_FILE='.*'

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

export PATH
export MANPATH

# -U: keep only the first occurrence of each duplicated value
# ref. http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-typeset
typeset -U PATH path MANPATH manpath

# ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
# ref. http://zsh.sourceforge.net/Doc/Release/Files.html
# ref. http://zsh.sourceforge.net/Doc/Release/Options.html#index-GLOBALRCS
setopt no_global_rcs

# copied from /etc/zprofile
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval "$(/usr/libexec/path_helper -s)"
fi

# Golang
export GOPATH="$HOME"

path=(
  ./node_modules/.bin # Node.js
  "$HOME/bin"(N-/)
  "$XDG_BIN_HOME"(N-/)
  /opt/homebrew/opt/coreutils/libexec/gnubin(N-/) # coreutils
  /opt/homebrew/opt/ed/libexec/gnubin(N-/) # ed
  /opt/homebrew/opt/findutils/libexec/gnubin(N-/) # findutils
  /opt/homebrew/opt/gawk/libexec/gnubin(N-/) # awk
  /opt/homebrew/opt/gnu-sed/libexec/gnubin(N-/) # sed
  /opt/homebrew/opt/gnu-tar/libexec/gnubin(N-/) # tar
  /opt/homebrew/opt/grep/libexec/gnubin(N-/) # grep
  $path
)

manpath=(
  /opt/homebrew/opt/coreutils/libexec/gnuman(N-/) # coreutils
  /opt/homebrew/opt/ed/libexec/gnuman(N-/) # ed
  /opt/homebrew/opt/findutils/libexec/gnuman(N-/) # findutils
  /opt/homebrew/opt/gawk/libexec/gnuman(N-/) # awk
  /opt/homebrew/opt/gnu-sed/libexec/gnuman(N-/) # sed
  /opt/homebrew/opt/gnu-tar/libexec/gnuman(N-/) # tar
  /opt/homebrew/opt/grep/libexec/gnuman(N-/) # grep
  $manpath
)
