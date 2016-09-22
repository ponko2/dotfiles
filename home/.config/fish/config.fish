set -x LANG ja_JP.UTF-8
set -x GITHUB_USER ponko2

set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH /usr/local/var/nodebrew/current/bin $PATH
set -x PATH $HOME/bin $PATH
set -x PATH $HOME/.composer/vendor/bin $PATH
set -x PATH $PATH ./node_modules/.bin

set -x EDITOR vim
set -x GOPATH $HOME
set -x GPG_TTY (tty)
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -x NODEBREW_ROOT /usr/local/var/nodebrew
set -x NOTIFY_COMMAND_COMPLETE_TIMEOUT 10
set -x RBENV_ROOT /usr/local/var/rbenv
