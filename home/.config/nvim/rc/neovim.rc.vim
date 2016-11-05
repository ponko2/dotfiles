scriptencoding utf-8

if !has('nvim') | finish | endif

"---------------------------------------------------------------------------
" Neovim:
"

" Enable true color
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Use cursor shape feature
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

if has('vim_starting')
  syntax off
endif

" Share the histories
autocmd MyAutoCmd CursorHold * if exists(':rshada') | rshada | wshada | endif


" vim: foldmethod=marker fileencoding=utf-8
