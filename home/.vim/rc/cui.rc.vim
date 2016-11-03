scriptencoding utf-8

if has('gui_running') | finish | endif

"---------------------------------------------------------------------------
" CUI:
"

" Color Scheme: "{{{

" Enable 256 color terminal.
set t_Co=256

if !exists('g:colors_name')
  set background=dark
  let g:solarized_termtrans = 1
  colorscheme solarized
endif

"}}}

" Mouse: "{{{

" Disable the mouse.
set mouse=
set mousemodel=

"}}}


" vim: foldmethod=marker fileencoding=utf-8
