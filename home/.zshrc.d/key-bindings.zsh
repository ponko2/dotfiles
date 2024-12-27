# Use the delete key
bindkey '^[[3~' delete-char

# historical backward/forward search with linehead string binded to ^P/^N
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# history search
if bindkey | grep -q '^"\^R" history-incremental-search-backward$' && \
  zle -la | grep -q '^history-incremental-pattern-search-backward$'; then
  bindkey '^R' history-incremental-pattern-search-backward
fi
if bindkey | grep -q '^"\^S" history-incremental-search-forward$' && \
  zle -la | grep -q '^history-incremental-pattern-search-forward$'; then
  bindkey '^S' history-incremental-pattern-search-forward
fi

# 直前のコマンドの最後の単語を挿入
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

# undo/redo
bindkey '^[u' undo
bindkey '^[r' redo

# ghq
function fzf-cd_ghq_list-widget() {
  setopt local_options pipefail no_aliases 2> /dev/null
  local dir="$(ghq list --full-path | fzf --scheme=path --no-multi --cycle --reverse)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line
  BUFFER="builtin cd -- ${(q)dir:a}"
  zle accept-line
  local ret=$?
  zle reset-prompt
  return $ret
}
zle -N fzf-cd_ghq_list-widget
bindkey '^X^G' fzf-cd_ghq_list-widget
