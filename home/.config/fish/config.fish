set -x LANG ja_JP.UTF-8
set -x GITHUB_USER ponko2

if which -s nvim
    set -x EDITOR nvim
    set -x GIT_EDITOR "nvim -u NONE -i NONE -N -c 'syntax on'"
else
    set -x EDITOR vim
    set -x GIT_EDITOR "vim -u NONE -i NONE -N -c 'syntax on'"
end

set -x GOPATH $HOME
set -x GPG_TTY (tty)
set -x NODEBREW_ROOT /usr/local/var/nodebrew
set -x RBENV_ROOT /usr/local/var/rbenv
set -x RBENV_SHELL fish

set -x JAVA_HOME (/usr/libexec/java_home -v 1.8)
set -x JRE_HOME $JAVA_HOME/jre
set -x M2_HOME (brew --prefix maven)/libexec
set -x MAVEN_HOME $M2_HOME

if test -d $RBENV_ROOT/shims
    set -x PATH $RBENV_ROOT/shims $PATH
end

if test -d $NODEBREW_ROOT/current/bin
    set -x PATH $NODEBREW_ROOT/current/bin $PATH
end

if test -d $GOPATH/bin
    set -x PATH $GOPATH/bin $PATH
end

set -x PATH ./node_modules/.bin $PATH
set -x PATH $PATH /usr/local/share/git-core/contrib/diff-highlight
