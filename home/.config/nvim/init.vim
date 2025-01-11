" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

scriptencoding utf-8

if filereadable(expand('~/.vimrc_secret'))
  execute 'source' expand('~/.vimrc_secret')
endif

" Use English interface.
language message C

" <Leader>
let g:mapleader = "\<Space>"
nnoremap <Space> <Nop>

" Minimize:
call vimrc#source_rc('minimize.rc.vim')

" Options:
call vimrc#source_rc('options.rc.vim')

" Autocmds:
call vimrc#source_rc('autocmds.rc.vim')

" Mappings:
call vimrc#source_rc('mappings.rc.vim')

" Commands:
call vimrc#source_rc('commands.rc.vim')

" Plugins:
call vimrc#source_rc('dein.rc.vim')

set secure
