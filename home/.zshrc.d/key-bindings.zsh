# Use emacs key bindings
bindkey -e
bindkey '^[[3~' delete-char

# historical backward/forward search with linehead string binded to ^P/^N
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey '^p' history-beginning-search-backward-end
bindkey '^n' history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# history search
if zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^r' history-incremental-pattern-search-backward
  bindkey '^s' history-incremental-pattern-search-forward
else
  bindkey '^r' history-incremental-search-backward
  bindkey '^s' history-incremental-search-forward
fi

# 直前のコマンドの最後の単語を挿入
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

# undo/redo
bindkey '^[u' undo
bindkey '^[r' redo
