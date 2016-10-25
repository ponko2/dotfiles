scriptencoding utf-8

"---------------------------------------------------------------------------
" FileType:
"

filetype plugin indent on
syntax enable

augroup MyAutoCmd
  " 長いブロックでもシンタックスハイライト
  autocmd FileType html,jsp,asp,php,xml,perl
        \ syntax sync minlines=500 maxlines=1000

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


" vim: foldmethod=marker fileencoding=utf-8
