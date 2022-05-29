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
  let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
  let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

"---------------------------------------------------------------------------
" Mouse:

" Disable the mouse.
set mouse=
set mousemodel=
