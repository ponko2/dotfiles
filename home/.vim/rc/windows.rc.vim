scriptencoding utf-8

if !IsWindows() | finish | endif

"---------------------------------------------------------------------------
" Windows:
"

" PATHに$VIMが含まれていないときにexeを見つけ出せない問題を修正
if $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

" 斜体表示をしない
let g:solarized_italic = 0


" vim: foldmethod=marker fileencoding=utf-8
