umask 022

if [ "$TERM" != 'dumb' ]; then
  stty -ixon -ixoff
fi

fpath=($XDG_CONFIG_HOME/anyframe(N-/) $fpath)

if [[ -f /usr/local/opt/zplug/init.zsh ]]; then
  source $XDG_CONFIG_HOME/zplug/init.zsh
fi

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
