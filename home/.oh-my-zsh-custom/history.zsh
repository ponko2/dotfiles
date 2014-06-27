## Command history configuration
if [ -d $HOME/Dropbox/History ]; then
  HISTFILE=$HOME/Dropbox/History/.zsh_history
else
  HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

# 履歴検索で重複しているものを表示しない
setopt hist_find_no_dups

# 同じコマンドが history に存在する場合は古い履歴を削除
setopt hist_ignore_all_dups

# 関数定義を履歴に残さない
setopt hist_no_functions

# history (fc -l) コマンドを履歴から削除
setopt hist_no_store

# コマンドの余計な空白を取り除いてから履歴に残す
setopt hist_reduce_blanks
