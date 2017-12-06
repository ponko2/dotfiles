scriptencoding utf-8

"---------------------------------------------------------------------------
" Syntax:
"

autocmd MyAutoCmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
      \ call vimrc#on_filetype()

if !has('vim_starting')
  filetype plugin indent on
  syntax enable
elseif !empty(argv())
  call vimrc#on_filetype()
endif
