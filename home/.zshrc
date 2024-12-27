# in ~/.zshenv, executed `unsetopt GLOBAL_RCS` and ignored /etc/zshrc
if [[ -r /etc/zshrc ]]; then
  source /etc/zshrc
fi

umask 022

if [ "$TERM" != 'dumb' ]; then
  stty -ixon -ixoff
fi

# History
if [[ -d "$XDG_STATE_HOME/zsh" ]]; then
  HISTFILE="$XDG_STATE_HOME/zsh/history"
else
  HISTFILE=~/.zsh_history
fi

# Use emacs key bindings
bindkey -e

if command -v sheldon >/dev/null; then
  eval "$(sheldon source)"
fi
