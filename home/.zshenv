# Language
export LANG=ja_JP.UTF-8

# XDG Base Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# autoload
autoload -Uz add-zsh-hook
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
autoload -Uz colors && colors
autoload -Uz history-search-end
autoload -Uz is-at-least
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz smart-insert-last-word
autoload -Uz url-quote-magic
autoload -Uz zcalc
autoload -Uz zmv

# Editor
if type nvim &> /dev/null; then
  export EDITOR='nvim -u NONE -i NONE -N +"syn on" +"set cb+=unnamed"'
else
  export EDITOR='vim -u NONE -i NONE -N +"syn on" +"set cb+=unnamed"'
fi
export CVSEDITOR="${EDITOR}"
export SVN_EDITOR="${EDITOR}"
export GIT_EDITOR="${EDITOR}"

# History
if [ -d $HOME/Dropbox/History ]; then
  export HISTFILE=$HOME/Dropbox/History/.zsh_history
else
  export HISTFILE=$HOME/.zsh_history
fi
export HISTSIZE=10000
export SAVEHIST=10000

setopt no_global_rcs

case ${OSTYPE} in
  darwin*)
    # Homebrew
    export PATH=/usr/local/bin:$PATH
    export PATH=/usr/local/sbin:$PATH

    # Git
    export GPG_TTY=$(tty)
    export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

    # Pager
    export PAGER=less

    # Less
    export LESS='-R'
    export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

    # Java
    export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
    export JRE_HOME=$JAVA_HOME/jre
    export M2_HOME=$(brew --prefix maven)/libexec
    export MAVEN_HOME=$M2_HOME
    ;;
esac

# Ruby
export RBENV_ROOT=/usr/local/var/rbenv
export PATH=$RBENV_ROOT/shims:$PATH

# Node.js
export NODEBREW_ROOT=/usr/local/var/nodebrew
export PATH=$NODEBREW_ROOT/current/bin:$PATH
export PATH=./node_modules/.bin:$PATH

# Golang
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH
