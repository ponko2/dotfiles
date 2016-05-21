export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/var/nodebrew/current/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH:./node_modules/.bin"

export LANG=ja_JP.UTF-8
export GPG_TTY=$(tty)
export RBENV_ROOT=/usr/local/var/rbenv
export NODEBREW_ROOT=/usr/local/var/nodebrew
export NOTIFY_COMMAND_COMPLETE_TIMEOUT=10

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
