source $HOME/.antigen/antigen.zsh

autoload -Uz is-at-least
if is-at-least 4.3.11; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*' recent-dirs-max 5000
  zstyle ':chpwd:*' recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

antigen use oh-my-zsh

case "${OSTYPE}" in
  linux*)
    antigen bundle marzocchi/zsh-notify
    ;;
  darwin*)
    antigen bundle osx
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle shrkw/zsh-notify --branch=tmux_support
    ;;
esac

antigen bundle git
antigen bundle autojump
antigen bundle rbenv

antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle mollifier/anyframe
antigen bundle mollifier/cd-gitroot
antigen bundle motemen/ghq zsh

antigen bundle $HOME/.oh-my-zsh-custom

antigen theme simple

antigen apply
