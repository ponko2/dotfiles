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

zinit ice from"gh-r" as"program" atload'eval "$(starship init zsh)"'
zinit light starship/starship

zinit wait lucid for \
  mollifier/cd-gitroot \
  atload"
    zstyle ':anyframe:selector:' use peco
    zstyle ':anyframe:selector:fzf:' command 'fzf --exact --no-sort --cycle --reverse --inline-info --ansi'
    bindkey '^r' anyframe-widget-put-history
    bindkey '^s' anyframe-widget-put-history
    bindkey '^xg' anyframe-widget-cd-ghq-repository
    bindkey '^x^g' anyframe-widget-cd-ghq-repository
    bindkey '^x^b' anyframe-widget-checkout-git-branch
    bindkey '^xr' anyframe-widget-execute-history
    bindkey '^x^r' anyframe-widget-execute-history
    bindkey '^xk' anyframe-widget-kill
    bindkey '^x^k' anyframe-widget-kill
    bindkey '^xi' anyframe-widget-insert-git-branch
    bindkey '^x^i' anyframe-widget-interactive-git-rebase
    bindkey '^xf' anyframe-widget-insert-filename
    bindkey '^x^f' anyframe-widget-interactive-git-commit-fixup
  " \
    mollifier/anyframe \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting

zinit wait lucid from"gh-r" as"program" for \
  mv"zoxide-*/zoxide -> zoxide" atload'eval "$(zoxide init zsh)"' \
    ajeetdsouza/zoxide

function source_snippets() {
  local snippet
  local snippets=("$HOME"/.zshrc.d/*.zsh(.N))
  for snippet in ${(o)snippets}; do
    zinit snippet $snippet
  done
}
source_snippets
unset -f source_snippets

if [[ -f ~/.fzf.zsh ]]; then
  zinit snippet ~/.fzf.zsh
fi

if [[ -f ~/.zshrc.local ]]; then
  zinit snippet ~/.zshrc.local
fi
