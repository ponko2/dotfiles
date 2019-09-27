scriptencoding utf-8

if !has('nvim') | finish | endif

"---------------------------------------------------------------------------
" Neovim:
"

let g:loaded_python_provider = 0

if IsMac()
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

if exists('&pumblend')
  set pumblend=20
endif

if exists('&winblend')
  set winblend=20
endif

" コマンドライン補完
set wildmenu
set wildmode=full
set wildoptions=tagfile,pum

" Enable true color
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Terminal setting.
command! -bang Terminal terminal<bang> zsh
autocmd MyAutoCmd TermOpen * setlocal modifiable
autocmd MyAutoCmd TermClose * buffer #
