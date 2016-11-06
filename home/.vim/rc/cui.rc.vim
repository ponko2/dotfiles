scriptencoding utf-8

if has('gui_running') | finish | endif

"---------------------------------------------------------------------------
" CUI:
"

" Mouse: "{{{

" Disable the mouse.
set mouse=
set mousemodel=

"}}}

" Color Scheme: "{{{

" Enable 256 color terminal.
set t_Co=256

if !exists('g:colors_name')
  set background=dark
  try
    colorscheme gruvbox
  catch
    colorscheme desert
  endtry
endif

"}}}


" vim: foldmethod=marker fileencoding=utf-8
