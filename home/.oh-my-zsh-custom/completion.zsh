# 補完候補を詰めて表示
setopt list_packed

# カッコの対応などを自動的に補完
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
#setopt auto_param_slash

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
#setopt mark_dirs

# 最後のスラッシュを自動的に削除しない
#setopt noautoremoveslash

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# =command を command のパス名に展開する
setopt equals

# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

# --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
