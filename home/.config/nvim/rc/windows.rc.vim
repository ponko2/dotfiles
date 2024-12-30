scriptencoding utf-8

if !IsWindows() | finish | endif

"---------------------------------------------------------------------------
" Windows:
"

" Setting of terminal encoding.
if IsCUI()
  " For system.
  set termencoding=cp932
endif

" Exchange path separator
set shellslash
if exists('&completeslash')
  set completeslash=slash
endif

" PATHに$VIMが含まれていないときにexeを見つけ出せない問題を修正
if $PATH !~? '\(^\|;\)' .. escape($VIM, '\\') .. '\(;\|$\)'
  let $PATH = $VIM .. ';' .. $PATH
endif
