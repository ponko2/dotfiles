scriptencoding utf-8

if !has('nvim') | finish | endif

"---------------------------------------------------------------------------
" Neovim:
"

if IsMac()
  let g:python_host_prog = '/usr/local/opt/python@2/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

if exists('&pumblend')
  set pumblend=20
endif

" Enable true color
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

autocmd MyAutoCmd FocusGained * checktime

" Terminal setting.
command! -bang Terminal terminal<bang> zsh
autocmd MyAutoCmd TermOpen * setlocal modifiable
autocmd MyAutoCmd TermClose * buffer #
