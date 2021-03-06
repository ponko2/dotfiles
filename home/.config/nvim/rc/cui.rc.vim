scriptencoding utf-8

if !IsCUI() | finish | endif

"---------------------------------------------------------------------------
" CUI:
"

"---------------------------------------------------------------------------
" Timeout:

set notimeout
set ttimeout
set ttimeoutlen=10

augroup FastEscape
  autocmd!
  autocmd InsertEnter * set timeoutlen=0
  autocmd InsertLeave * set timeoutlen=1000
augroup END

"---------------------------------------------------------------------------
" Color:

" Enable true color
if exists('+termguicolors')
  set termguicolors
endif

"---------------------------------------------------------------------------
" Mouse:

" Disable the mouse.
set mouse=
set mousemodel=
