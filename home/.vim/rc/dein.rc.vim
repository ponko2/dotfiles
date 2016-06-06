scriptencoding utf-8

if !(executable('rsync') && executable('git')) | finish | endif

"---------------------------------------------------------------------------
" Dein.vim:
"

let $CACHE = expand('~/.cache')

if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif

" Load dein.
if has('vim_starting')
  let s:dein_dir = finddir('dein.vim', '.;')
  if s:dein_dir !=# '' || &runtimepath !~# '/dein.vim'
    if s:dein_dir ==# '' && &runtimepath !~# '/dein.vim'
      let s:dein_dir = expand('$CACHE/dein')
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
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
  finish
endif

call dein#begin(s:path, [expand('<sfile>')]
      \ + split(glob('~/.vim/rc/*.toml'), '\n'))

call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/rc/dein-lazy.toml', {'lazy' : 1})

call dein#end()
call dein#save_state()

if !has('vim_starting')
  " Installation check.
  if dein#check_install()
    call dein#install()
  endif

  call dein#call_hook('source')
  call dein#call_hook('post_source')

  filetype plugin indent on
  syntax enable
endif


" vim: foldmethod=marker fileencoding=utf-8
