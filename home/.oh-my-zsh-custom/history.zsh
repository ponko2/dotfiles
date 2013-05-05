## Command history configuration
if [ -d $HOME/Dropbox/History ]; then
  HISTFILE=$HOME/Dropbox/History/.zsh_history
else
  HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

# history (fc -l) no store
setopt hist_no_store
