scriptencoding utf-8

"---------------------------------------------------------------------------
" FileType:
"

augroup MyAutoCmd
  " 長いブロックでもシンタックスハイライト
  autocmd FileType html,xml
        \ syntax sync minlines=500 maxlines=1000
  autocmd CursorHold *.js,*.toml
        \ syntax sync minlines=500 maxlines=1000
  autocmd FileType vue syntax sync fromstart

  " * を使用した検索時等の区切り文字を調整
  autocmd FileType html,css,scss,less
        \ setlocal iskeyword& iskeyword+=-
  autocmd FileType javascript,vue
        \ setlocal iskeyword& iskeyword+=$,-

  " コメントの自動挿入をしない
  autocmd FileType,Syntax,BufEnter,BufWinEnter *
        \ setlocal formatoptions-=ro | setlocal formatoptions+=mM

  " Reload .vimrc automatically.
  autocmd BufWritePost .vimrc,vimrc,*.rc.vim,*.toml
        \ | source $MYVIMRC | redraw

  " Auto reload VimScript.
  autocmd BufWritePost,FileWritePost *.vim nested
        \ if &l:autoread > 0 | source <afile> |
        \   echo 'source ' . bufname('%') |
        \ endif
augroup END


" vim: fileencoding=utf-8
