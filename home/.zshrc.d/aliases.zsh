case "${OSTYPE}" in
  linux*)
    if command -v xsel >/dev/null; then
      alias pbcopy='xsel --input --clipboard'
    fi
    if [[ -d /mnt/c/Windows ]]; then
      alias scp='scp.exe'
      alias ssh='ssh.exe'
      alias ssh-add='ssh-add.exe'

      if command -v gh.exe >/dev/null; then
        function gh() {
          if [[ $(pwd -P) = /mnt/* ]]; then
            gh.exe "$@"
          else
            command gh "$@"
          fi
        }
      fi

      if command -v git.exe >/dev/null; then
        function git() {
          if [[ $(pwd -P) = /mnt/* ]]; then
            git.exe "$@"
          else
            command git "$@"
          fi
        }
      fi

      function open() {
        if [[ $# != 1 ]]; then
          explorer.exe .
        elif [[ -e $1 ]]; then
          cmd.exe /c start $(wslpath -w $1) 2> /dev/null
        else
          echo "open: $1: No such file or directory."
        fi
      }
    else
      if command -v xdg-open >/dev/null; then
        alias open='xdg-open'
      fi
    fi
    ;;
  cygwin*)
    alias pbcopy='putclip'
    alias open='cygstart'
    ;;
esac

# ls
if command -v lsd >/dev/null; then
  alias ls='lsd --icon=never --date="+%Y-%m-%dT%H:%M:%S%z"'
elif command -v eza >/dev/null; then
  alias ls='eza --time-style="long-iso"'
fi

# diff
if command -v colordiff >/dev/null; then
  alias diff='colordiff'
fi

# Vim
alias vi='vim'
