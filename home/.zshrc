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

fpath=($XDG_CONFIG_HOME/anyframe(N-/) $fpath)

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-readurl \
  zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit wait lucid for \
  ponko2/cd-gitroot \
  atload"
    zstyle ':anyframe:selector:' use peco
    zstyle ':anyframe:selector:fzf:' command 'fzf --exact --no-sort --cycle --reverse --no-unicode --ansi'
    bindkey '^r' anyframe-widget-put-history
    bindkey '^s' anyframe-widget-put-history
    bindkey '^x^b' anyframe-widget-checkout-git-branch
    bindkey '^x^d' anyframe-widget-insert-git-diff-filename
    bindkey '^xf' anyframe-widget-insert-filename
    bindkey '^x^f' anyframe-widget-interactive-git-commit-fixup
    bindkey '^xg' anyframe-widget-cd-ghq-repository
    bindkey '^x^g' anyframe-widget-cd-ghq-repository
    bindkey '^xi' anyframe-widget-insert-git-branch
    bindkey '^x^i' anyframe-widget-interactive-git-rebase
    bindkey '^xk' anyframe-widget-kill
    bindkey '^x^k' anyframe-widget-kill
    bindkey '^xr' anyframe-widget-execute-history
    bindkey '^x^r' anyframe-widget-execute-history
  " \
    mollifier/anyframe \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting

if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v fnm >/dev/null; then
  eval "$(fnm env)"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

function source_snippets() {
  local snippet
  local snippets=("$HOME"/.zshrc.d/*.zsh(.N))
  for snippet in ${(o)snippets}; do
    zinit snippet $snippet
  done
}
source_snippets
unset -f source_snippets

if [[ -f "$XDG_CONFIG_HOME/fzf/fzf.zsh" ]]; then
  source "$XDG_CONFIG_HOME/fzf/fzf.zsh"
fi

_prompt_executing=""
function __prompt_precmd() {
    local ret="$?"
    if test "$_prompt_executing" != "0"
    then
      _PROMPT_SAVE_PS1="$PS1"
      _PROMPT_SAVE_PS2="$PS2"
      PS1=$'%{\e]133;P;k=i\a%}'$PS1$'%{\e]133;B\a\e]122;> \a%}'
      PS2=$'%{\e]133;P;k=s\a%}'$PS2$'%{\e]133;B\a%}'
    fi
    if test "$_prompt_executing" != ""
    then
      printf "\033]133;D;%s;aid=%s\007" "$ret" "$$"
    fi
    printf "\033]133;A;cl=m;aid=%s\007" "$$"
    _prompt_executing=0
}
function __prompt_preexec() {
    PS1="$_PROMPT_SAVE_PS1"
    PS2="$_PROMPT_SAVE_PS2"
    printf "\033]133;C;\007"
    _prompt_executing=1
}
preexec_functions+=(__prompt_preexec)
precmd_functions+=(__prompt_precmd)

if [[ -f ~/.zshrc.local ]]; then
  zinit snippet ~/.zshrc.local
fi
