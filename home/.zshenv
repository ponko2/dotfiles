export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH:./node_modules/.bin"

export GPG_TTY=$(tty)
export RBENV_ROOT=/usr/local/var/rbenv
export DOCKER_HOST=tcp://localhost:4243

export NOTIFY_COMMAND_COMPLETE_TIMEOUT=10

export LANG=ja_JP.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi
