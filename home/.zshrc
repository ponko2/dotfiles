umask 022

if [ "$TERM" != 'dumb' ]; then
  stty -ixon -ixoff
fi

fpath=($XDG_CONFIG_HOME/anyframe(N-/) $fpath)

if [[ -f /usr/local/opt/zplug/init.zsh ]]; then
  source $XDG_CONFIG_HOME/zplug/init.zsh
fi

function source_snippets() {
  local snippet
  local snippets=("$HOME"/.zshrc.d/*.zsh(.N))
  for snippet in ${(o)snippets}; do
    source "$snippet"
  done
}
source_snippets
unset -f source_snippets

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
