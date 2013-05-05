setopt complete_aliases

alias :q="exit"

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

alias vi='vim'

alias gr="git-root"
