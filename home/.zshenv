# Language
export LANG=ja_JP.UTF-8

# XDG Base Directory
export XDG_BIN_HOME=$HOME/.local/bin
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

export PATH
export MANPATH

# -U: keep only the first occurrence of each duplicated value
# ref. http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-typeset
typeset -U PATH path MANPATH manpath FPATH fpath

# ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
# ref. http://zsh.sourceforge.net/Doc/Release/Files.html
# ref. http://zsh.sourceforge.net/Doc/Release/Options.html#index-GLOBALRCS
setopt no_global_rcs

# path_helper reorders PATH each time it runs, so child shells skip the rest of this block.
if [ -n "${__HOME_ZSHENV_SOURCED-}" ]; then return; fi
export __HOME_ZSHENV_SOURCED=1

# copied from /etc/zprofile
# system-wide environment settings for zsh(1)
if [[ -x /usr/libexec/path_helper ]]; then
  eval "$(/usr/libexec/path_helper -s)"
fi

# mise
# ref. https://mise.jdx.dev/bootstrap/packages/brew.html#the-prefix
# ref. https://docs.brew.sh/Tips-and-Tricks#load-homebrew-from-the-same-dotfiles-on-different-operating-systems
path=(/opt/homebrew/bin(N-/) /home/linuxbrew/.linuxbrew/bin(N-/) $path)

# Homebrew
command -v brew && eval "$(brew shellenv)"

# Nix
if [[ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
  source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

# Prefer user-local binaries over other globally installed tools.
path=("$XDG_BIN_HOME"(N-/) $path)
