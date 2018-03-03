scriptencoding utf-8

if !has('nvim') | finish | endif

"---------------------------------------------------------------------------
" Neovim:
"

if IsMac()
  let g:python_host_prog = '/usr/local/opt/python@2/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python'
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

" Enable true color
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Use cursor shape feature
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

" Share the histories
autocmd MyAutoCmd CursorHold * if exists(':rshada') | rshada | wshada | endif

autocmd MyAutoCmd FocusGained * checktime

" Terminal setting.
command! -bang Terminal terminal<bang> zsh
augroup Terminal
  autocmd!
  autocmd TermOpen * setlocal modifiable
  autocmd TermClose * buffer #
augroup END


" vim: foldmethod=marker fileencoding=utf-8
