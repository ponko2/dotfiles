scriptencoding utf-8

if !executable('git') | finish | endif

"---------------------------------------------------------------------------
" Dein.vim:
"

" Load dein.
if has('vim_starting')
  let s:dein_dir = finddir('dein.vim', '.;')
  if s:dein_dir !=# '' || &runtimepath !~# '/dein.vim'
    if s:dein_dir ==# '' && &runtimepath !~# '/dein.vim'
      let s:dein_dir = expand('$XDG_DATA_HOME/dein')
            \. '/repos/github.com/Shougo/dein.vim'
      if !isdirectory(s:dein_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
      endif
    endif
    execute ' set runtimepath^=' . substitute(
          \ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
  endif
endif

let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1
let g:dein#install_log_filename = expand('~/dein.log')

let s:path = expand('$XDG_DATA_HOME/dein')
if !dein#load_state(s:path)
  finish
endif

call dein#begin(s:path, expand('<sfile>'))

call dein#load_toml(expand('$XDG_CONFIG_HOME/nvim/rc/dein.toml'), {'lazy': 0})
call dein#load_toml(expand('$XDG_CONFIG_HOME/nvim/rc/dein-lazy.toml'), {'lazy' : 1})

if has('nvim')
  call dein#load_toml(expand('$XDG_CONFIG_HOME/nvim/rc/dein-neovim.toml'), {'lazy' : 1})
endif

call dein#end()
call dein#save_state()

" Installation check.
if dein#check_install()
  call dein#install()
endif

if !has('vim_starting')
  call dein#call_hook('source')
  call dein#call_hook('post_source')
endif


" vim: foldmethod=marker fileencoding=utf-8
