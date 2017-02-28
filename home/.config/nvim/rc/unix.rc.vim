scriptencoding utf-8

if IsWindows() | finish | endif

"---------------------------------------------------------------------------
" UNIX:
"

if &shell =~# 'fish$'
  set shell=sh
endif


" vim: foldmethod=marker fileencoding=utf-8
