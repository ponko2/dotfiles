set -x LANG ja_JP.UTF-8
set -x GITHUB_USER ponko2

set -x EDITOR vim
set -x GOPATH $HOME
set -x GPG_TTY (tty)
set -x NODEBREW_ROOT /usr/local/var/nodebrew
set -x RBENV_ROOT /usr/local/var/rbenv
set -x RBENV_SHELL fish

set -x PATH $HOME/.cargo/bin $PATH
set -x PATH $HOME/.composer/vendor/bin $PATH
set -x PATH $RBENV_ROOT/shims $PATH
set -x PATH $NODEBREW_ROOT/current/bin $PATH
set -x PATH ./node_modules/.bin $PATH
set -x PATH $GOPATH/bin $PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH /usr/local/bin $PATH
