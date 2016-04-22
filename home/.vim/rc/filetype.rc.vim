scriptencoding utf-8

"---------------------------------------------------------------------------
" FileType:
"

filetype plugin indent on
syntax enable

augroup MyAutoCmd
  " コメントの自動挿入をしない
  autocmd FileType,Syntax,BufEnter,BufWinEnter *
        \ setlocal formatoptions-=ro | setlocal formatoptions+=mM

  " Auto reload VimScript.
  autocmd BufWritePost,FileWritePost *.vim nested
        \ if &l:autoread > 0 | source <afile> |
        \   echo 'source ' . bufname('%') |
        \ endif

  " Reload .vimrc automatically.
  autocmd BufWritePost .vimrc,vimrc,*.rc.vim,*.toml
        \ | source $MYVIMRC | redraw
augroup END


" vim: foldmethod=marker fileencoding=utf-8
