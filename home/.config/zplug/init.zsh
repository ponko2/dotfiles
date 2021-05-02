# init
export ZPLUG_HOME=/usr/local/opt/zplug
export ZPLUG_LOADFILE=$XDG_CONFIG_HOME/zplug/packages.zsh
export ZPLUG_CACHE_DIR=$XDG_CACHE_HOME/zplug
export ZPLUG_REPOS=$XDG_DATA_HOME/zplug/repos
export ZPLUG_BIN=$XDG_DATA_HOME/zplug/bin
source $ZPLUG_HOME/init.zsh

# Then, source plugins and add commands to $PATH
zplug load # --verbose
