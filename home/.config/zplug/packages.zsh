# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# theme
zplug 'mafredri/zsh-async', use:async.zsh, from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme

# plugins
zplug 'b4b4r07/enhancd', use:init.sh
zplug 'mollifier/anyframe'
zplug 'mollifier/cd-gitroot'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# local plugins
zplug "$XDG_CONFIG_HOME/zplug/custom", from:local, use:'*.zsh'
