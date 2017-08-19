set -x LANG ja_JP.UTF-8
set -x GITHUB_USER ponko2

set -x EDITOR vim
set -x GOPATH $HOME
set -x GPG_TTY (tty)
set -x NODEBREW_ROOT /usr/local/var/nodebrew
set -x RBENV_ROOT /usr/local/var/rbenv
set -x RBENV_SHELL fish

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
