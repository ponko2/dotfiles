case "${OSTYPE}" in
  linux*)
    alias pbcopy='xsel --input --clipboard'
    alias open='gnome-open'
    ;;
  cygwin*)
    alias pbcopy='putclip'
    alias open='cygstart'
    ;;
esac

# Disable correction.
alias cp='nocorrect cp'
alias ln='nocorrect ln'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias sudo='nocorrect sudo'

# ls
if type exa &> /dev/null; then
  alias ls='exa --time-style="long-iso"'
fi

# diff
if type colordiff &> /dev/null; then
  alias diff='colordiff'
fi

# Git
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --amend --no-edit'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log --decorate'
alias glg='git log --decorate --graph'
alias glo='git log --decorate --oneline'
alias gm='git merge'
alias gs='git status'
alias gss='git status -s'
alias gr='cd-gitroot'
