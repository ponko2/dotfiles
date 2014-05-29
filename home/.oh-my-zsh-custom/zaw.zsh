bindkey '^R' zaw-history

bindkey '^x^c' zaw-cdr
bindkey '^x^b' zaw-git-recent-branches
bindkey '^x^f' zaw-git-files

bindkey -M filterselect '\e' send-break
bindkey -M filterselect '^E' accept-search

zstyle ':filter-select:highlight' matched fg=yellow,standout
zstyle ':filter-select' max-lines 10 # use 10 lines for filter-select
zstyle ':filter-select' max-lines -10 # use $LINES - 10 for filter-select
zstyle ':filter-select' rotate-list yes # enable rotation for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search
zstyle ':filter-select' extended-search yes # see below
