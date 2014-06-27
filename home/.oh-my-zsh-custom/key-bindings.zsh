# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p"   history-beginning-search-backward-end
bindkey "^n"   history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# history incremental search
if zle -la | grep -q '^peco-history$'; then
  bindkey '^r' peco-history
elif zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^r' history-incremental-pattern-search-backward
  bindkey '^s' history-incremental-pattern-search-forward
else
  bindkey '^r' history-incremental-search-backward
  bindkey '^s' history-incremental-search-forward
fi

# ディレクトリ移動の履歴を検索
if zle -la | grep -q '^peco-cdr$'; then
  bindkey '^x^d' peco-cdr
fi

# 直前のコマンドの最後の単語を挿入
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

# undo/redo
bindkey "^[u" undo
bindkey "^[r" redo
