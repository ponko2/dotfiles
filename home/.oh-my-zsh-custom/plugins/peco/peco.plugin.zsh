function _peco-clear-screen() {
  zle clear-screen
}

function _peco-tac() {
  if which tac &> /dev/null; then
      eval "tac"
  else
      eval "tail -r"
  fi
}

function peco-history() {
  BUFFER=$(fc -l -n 1 | _peco-tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER

  _peco-clear-screen
}
zle -N peco-history

function peco-cdr() {
  local output=$(cdr -l | awk '{ print $2 }' | peco)

  if [ -n "$output" ]; then
    BUFFER="cd $output"
    zle accept-line
  fi

  _peco-clear-screen
}
zle -N peco-cdr
