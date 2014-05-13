setopt complete_aliases

alias :q='exit'

case "${OSTYPE}" in
  linux*)
    alias pbcopy='xsel --input --clipboard'
    alias open='gnome-open'
    ;;
  cygwin*)
    alias pbcopy='putclip'
    alias open='cygstart'
    ;;
  darwin*)
    alias -g photoshop='open -b com.adobe.Photoshop'
    alias -g illustrator='open -b com.adobe.Illustrator'
    ;;
esac

alias vi='vim'

alias gr='git-root'

alias rsync='rsync -C --filter=":- .gitignore"'
