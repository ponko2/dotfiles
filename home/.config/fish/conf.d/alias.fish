# git
function gr -d "Change working directory to git repository root"
    git_is_repo; and cd (git rev-parse --show-toplevel)
end

# ls
if which -s exa
    alias ls="exa --time-style='long-iso'"
end

# diff
if which -s colordiff
    alias diff="colordiff"
end

# vim
if which -s nvim
    alias vim="nvim"
end
