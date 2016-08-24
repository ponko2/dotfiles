# Git
function gr -d "Change working directory to git repository root"
    git_is_repo; and cd (git rev-parse --show-toplevel)
end
