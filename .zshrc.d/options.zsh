# カーソル位置は保持したまま完候補補を順次その場で表示
setopt always_last_prompt

# ヒストリファイルを上書きするのではなく、追加するようにする
setopt append_history

# ディレクトリ名でcd
setopt auto_cd

# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

#普通のcdでもスタックに入れる
setopt auto_pushd

# 最後のスラッシュを自動的に削除
setopt auto_remove_slash

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt auto_resume

# !を使ったヒストリ展開を行う
setopt bang_hist

# no beep
setopt no_beep
setopt no_hist_beep
setopt no_list_beep

# {a-c} を a b c に展開する機能を使えるようにする
#setopt brace_ccl

# Ignore case when glob
setopt no_case_glob

# リダイレクト(>, >&, <>)で既存ファイルを上書きしない
setopt no_clobber

# OSX濁点半濁点
setopt combining_chars

# エイリアスも補完対象に設定
setopt no_complete_aliases

# 語の途中でもカーソル位置で補完
setopt complete_in_word

# コマンドのスペル訂正を使用しない
setopt no_correct

# コマンドの引数訂正を使用しない
setopt no_correct_all

# =command を command のパス名に展開する
setopt equals

# 拡張パターンマッチングを使用
setopt extended_glob

# ヒストリに時刻情報もつける
setopt extended_history

# Ctrl+S/Ctrl+Q No flow control
setopt no_flow_control

# 明確なドットの指定なしで . から始まるファイルにマッチさせる
setopt globdots

# 履歴がいっぱいの時は最も古いものを先ず削除
setopt hist_expire_dups_first

# 履歴検索で重複しているものを表示しない
setopt hist_find_no_dups

# 同じコマンドが history に存在する場合は古い履歴を削除
setopt hist_ignore_all_dups

# 前のコマンドと同じなら履歴に残さない
setopt hist_ignore_dups

# 余分な空白は詰めて履歴に残す
setopt hist_ignore_space

# 関数定義を履歴に残さない
setopt hist_no_functions

# history (fc -l) コマンドを履歴から削除
setopt hist_no_store

# コマンドの余計な空白を取り除いてから履歴に残す
setopt hist_reduce_blanks

# 古いコマンドと同じものは履歴に残さない
setopt hist_save_no_dups

# 実行するまえに展開結果を確認できるようにする
setopt hist_verify

# Ctrl+D -> use exit or logout
setopt ignore_eof

# 履歴をインクリメンタルに追加
setopt inc_append_history

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# 補完候補を詰めて表示
#setopt list_packed

# 補完対象ファイルの末尾に識別マークをつける
setopt list_types

# jobsにプロセスIDを表示
setopt long_list_jobs

# --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

# メールファイルにアクセスがあったときに警告
setopt mail_warning

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 複数のリダイレクトやパイプに対応
setopt multios

# globを展開できなかったときのエラーを無効化
setopt no_nomatch

# ジョブの状態をただちに知らせる
setopt notify

# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

# コマンドに / が含まれているとき PATH 中のサブディレクトリを探す
setopt path_dirs

# 8bit Japanese File support
setopt print_eight_bit

# 戻り値が 0 以外の場合終了コードを表示する
setopt print_exit_value

# 出力の文字列末尾に改行コードが無い場合でも表示
setopt no_prompt_cr

# 同じディレクトリを pushd しない
setopt pushd_ignore_dups

# Replace 'cd -' with 'cd +'
setopt pushd_minus

# pushd を引数なしで実行した場合は pushd $HOME とみなす
setopt pushd_to_home

# シングルクォートで囲まれた文字列内部で `''' をシングルクォートとして扱う
setopt rc_quotes

# rm * を実行する前に10秒待つ
setopt rm_star_wait

# クォートなしの変数展開時に展開された値を空白文字で分割する
#setopt sh_word_split

# 履歴を共有する
setopt share_history

# for, repeat, select, if, function support
#setopt short_loops

# URL文字列を自動エスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
