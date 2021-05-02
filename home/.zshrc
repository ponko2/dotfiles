umask 022

if [ "$TERM" != 'dumb' ]; then
  stty -ixon -ixoff
fi

fpath=($XDG_CONFIG_HOME/anyframe(N-/) $fpath)

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

zinit light-mode for \
  b4b4r07/enhancd \
  mollifier/anyframe \
  mollifier/cd-gitroot

zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting

function source_snippets() {
  local snippet
  local snippets=("$HOME"/.zshrc.d/*.zsh(.N))
  for snippet in ${(o)snippets}; do
    zinit snippet $snippet
  done
}
source_snippets
unset -f source_snippets

if [[ -f ~/.zshrc.local ]]; then
  zinit snippet ~/.zshrc.local
fi
