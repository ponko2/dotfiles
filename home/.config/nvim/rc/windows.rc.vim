scriptencoding utf-8

if !IsWindows() | finish | endif

"---------------------------------------------------------------------------
" Windows:
"

" PATHに$VIMが含まれていないときにexeを見つけ出せない問題を修正
if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif


" vim: foldmethod=marker fileencoding=utf-8
