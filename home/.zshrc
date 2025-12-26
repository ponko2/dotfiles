# in ~/.zshenv, executed `unsetopt GLOBAL_RCS` and ignored /etc/zshrc
if [[ -r /etc/zshrc ]]; then
  source /etc/zshrc
fi

umask 022

if [[ "$TERM" != 'dumb' ]]; then
  stty -ixon -ixoff
fi

# Correction
CORRECT_IGNORE='_*'
CORRECT_IGNORE_FILE='.*'

# History
HISTSIZE=10000
SAVEHIST=10000
HISTORY_IGNORE='(* --help|(bat|cat|cd|chmod|chown|cp|echo|ls|man|mv|rm|which)(| *)|git (add|blame|checkout|cherry-pick|commit|diff|log|rebase|reset|revert|show|status) *|{*)'
if [[ -d "$XDG_STATE_HOME/zsh" ]]; then
  export HISTFILE="$XDG_STATE_HOME/zsh/history"
else
  export HISTFILE=~/.zsh_history
fi

# Use emacs key bindings
bindkey -e

if command -v sheldon >/dev/null; then
  eval "$(sheldon source)"
fi
