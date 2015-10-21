# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p"   history-beginning-search-backward-end
bindkey "^n"   history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# history search
if zle -la | grep -q '^anyframe-widget-'; then
  bindkey '^r' anyframe-widget-put-history
  bindkey '^s' anyframe-widget-put-history
elif zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^r' history-incremental-pattern-search-backward
  bindkey '^s' history-incremental-pattern-search-forward
else
  bindkey '^r' history-incremental-search-backward
  bindkey '^s' history-incremental-search-forward
fi

# 直前のコマンドの最後の単語を挿入
autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
zstyle :insert-last-word match '*([^[:space:]][[:alpha:]/\\]|[[:alpha:]/\\][^[:space:]])*'
bindkey '^]' insert-last-word

# undo/redo
bindkey "^[u" undo
bindkey "^[r" redo

# anyframe
if zle -la | grep -q '^anyframe-widget-'; then
  bindkey '^xb' anyframe-widget-cdr
  bindkey '^x^b' anyframe-widget-checkout-git-branch

  bindkey '^xr' anyframe-widget-execute-history
  bindkey '^x^r' anyframe-widget-execute-history

  bindkey '^xp' anyframe-widget-put-history
  bindkey '^x^p' anyframe-widget-put-history

  bindkey '^xg' anyframe-widget-cd-ghq-repository
  bindkey '^x^g' anyframe-widget-cd-ghq-repository

  bindkey '^xk' anyframe-widget-kill
  bindkey '^x^k' anyframe-widget-kill

  bindkey '^xi' anyframe-widget-insert-git-branch
  bindkey '^x^i' anyframe-widget-interactive-git-rebase

  bindkey '^xf' anyframe-widget-insert-filename
  bindkey '^x^f' anyframe-widget-interactive-git-commit-fixup
fi
