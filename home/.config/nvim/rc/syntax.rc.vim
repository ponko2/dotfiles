scriptencoding utf-8

"---------------------------------------------------------------------------
" Syntax:
"

syntax enable

autocmd MyAutoCmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
      \ call vimrc#on_filetype()

if has('vim_starting') && !empty(argv())
  call vimrc#on_filetype()
endif
