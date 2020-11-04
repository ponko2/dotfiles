" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = expand('$HOME/.config')
endif

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = expand('$HOME/.cache')
endif

if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = expand('$HOME/.local/share')
endif

if filereadable(expand('~/.vimrc_secret'))
  execute 'source' expand('~/.vimrc_secret')
endif

" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

" Initialize:
call vimrc#source_rc('init.rc.vim')

" Dein:
call vimrc#source_rc('dein.rc.vim')

" Syntax:
call vimrc#source_rc('syntax.rc.vim')

" Options:
call vimrc#source_rc('options.rc.vim')

" Mappings:
call vimrc#source_rc('mappings.rc.vim')

" Commands:
call vimrc#source_rc('commands.rc.vim')

" Platform:
call vimrc#source_rc('windows.rc.vim')
call vimrc#source_rc('unix.rc.vim')
call vimrc#source_rc('mac.rc.vim')
call vimrc#source_rc('neovim.rc.vim')
call vimrc#source_rc('gui.rc.vim')
call vimrc#source_rc('cui.rc.vim')

set secure
