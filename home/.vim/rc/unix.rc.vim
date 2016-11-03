scriptencoding utf-8

if IsWindows() | finish | endif

"---------------------------------------------------------------------------
" UNIX:
"

" :grep で使われるプログラムの指定
if executable('ag')
  set grepprg="ag --smart-case --vimgrep $*"
  set grepformat=%f:%l:%c:%m
else
  set grepprg="grep -inH $*"
endif

if &shell =~# 'fish$'
  set shell=sh
endif


" vim: foldmethod=marker fileencoding=utf-8
