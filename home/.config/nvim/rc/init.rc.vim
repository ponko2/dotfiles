scriptencoding utf-8

if !has('vim_starting') | finish | endif

"---------------------------------------------------------------------------
" Initialize:
"

" Platform check
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
      \ && (has('mac') || has('macunix') || has('gui_macvim') || has('gui_vimr')
      \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

let s:is_gui = has('gui_running') || has('gui_vimr')

function! IsGUI() abort
  return s:is_gui
endfunction

function! IsCUI() abort
  return !s:is_gui
endfunction

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
if has('vim_starting') && &encoding !=# 'utf-8'
  if IsWindows() && !has('gui_running')
    set encoding=cp932
  else
    set encoding=utf-8
  endif
endif

" Build encodings.
let &fileencodings = join([
      \   'ucs-bom',
      \   'iso-2022-jp-3',
      \   'utf-8',
      \   'euc-jp',
      \   'cp932'
      \ ], ',')

" Setting of terminal encoding.
if !has('gui_running') && IsWindows()
  " For system.
  set termencoding=cp932
endif

" Use English interface.
language message C

" <Leader>
let g:mapleader = "\<Space>"
nnoremap <Space> <Nop>

" Exchange path separator
if IsWindows()
  set shellslash
endif

" Disable menu.vim
if has('gui_running')
  set guioptions=Mc
endif

" Disable default plugins
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_2html_plugin      = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_matchparen        = 1
let g:loaded_LogiPat           = 1
let g:loaded_logipat           = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_man               = 1


" vim: fileencoding=utf-8
