scriptencoding utf-8

if !has('nvim') | finish | endif

"---------------------------------------------------------------------------
" Neovim:
"

if has('vim_starting') && empty(argv())
  syntax off
endif

if IsMac()
  let g:python_host_prog = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
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

" Terminal setting.
command! -bang Terminal terminal<bang> $SHELL
tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> <C-w><C-h> <C-\><C-n><C-w><C-h>
tnoremap <silent> <C-w><C-j> <C-\><C-n><C-w><C-j>
tnoremap <silent> <C-w><C-k> <C-\><C-n><C-w><C-k>
tnoremap <silent> <C-w><C-l> <C-\><C-n><C-w><C-l>
tnoremap <silent> <C-w><C-w> <C-\><C-n><C-w><C-w>
tnoremap <silent> <C-w>h <C-\><C-n><C-w>h
tnoremap <silent> <C-w>j <C-\><C-n><C-w>j
tnoremap <silent> <C-w>k <C-\><C-n><C-w>k
tnoremap <silent> <C-w>l <C-\><C-n><C-w>l
tnoremap <silent> <C-w>w <C-\><C-n><C-w>w


" vim: foldmethod=marker fileencoding=utf-8
