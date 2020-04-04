if !has('vim_starting') | finish | endif

"---------------------------------------------------------------------------
" Initialize:
"

" Platform check
function! IsWindows() abort
  return has('win32') || has('win64')
endfunction

function! IsMac() abort
  return !IsWindows() && !has('win32unix')
      \ && (has('mac') || has('macunix') || has('gui_macvim')
      \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

function! IsGUI() abort
  return has('gui_running')
endfunction

function! IsCUI() abort
  return !IsGUI()
endfunction

set fileformat=unix

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
if has('vim_starting') && &encoding !=# 'utf-8'
  if IsWindows() && IsCUI()
    set encoding=cp932
  else
    set encoding=utf-8
  endif
endif

scriptencoding utf-8

" Build encodings.
let &fileencodings = join([
      \   'ucs-bom',
      \   'iso-2022-jp-3',
      \   'utf-8',
      \   'euc-jp',
      \   'cp932'
      \ ], ',')

" Use English interface.
language message C

" <Leader>
let g:mapleader = "\<Space>"
nnoremap <Space> <Nop>

let g:no_vimrc_example  = 1
let g:no_gvimrc_example = 1

let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1

let g:skip_loading_mswin = 1

" Disable default plugins
let g:loaded_2html_plugin      = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_logiPat           = 1
let g:loaded_man               = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
