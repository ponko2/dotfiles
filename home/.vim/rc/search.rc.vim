scriptencoding utf-8

"---------------------------------------------------------------------------
" Search:
"

" * 等での検索時 - で切らない
set iskeyword& iskeyword+=-

" 大文字と小文字を無視する
set ignorecase

" 検索パターンが大文字を含んでいたらオプション ignorecase を無効にする
set smartcase

" インクリメンタルサーチを有効にする
set incsearch

" 検索パターンを強調表示しない
set nohlsearch

" 検索がファイル末尾まで進んだらファイル先頭から再び検索する
set wrapscan


" vim: foldmethod=marker fileencoding=utf-8
