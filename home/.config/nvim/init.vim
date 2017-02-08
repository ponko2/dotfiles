scriptencoding utf-8

" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Enable no Vi compatible commands "{{{
if &compatible
  set nocompatible
endif
"}}}

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = expand('$HOME/.config')
endif

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = expand('$HOME/.cache')
endif

if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = expand('$HOME/.local/share')
endif

function! s:source_rc(path, ...) abort "{{{
  let l:use_global = get(a:000, 0, !has('vim_starting'))
  let l:abspath = resolve(expand('$XDG_CONFIG_HOME/nvim/rc/' . a:path))

  if !l:use_global
    execute 'source' fnameescape(l:abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let l:content = map(readfile(l:abspath),
        \ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")

  " create tempfile and source the tempfile
  let l:tempfile = tempname()

  try
    call writefile(l:content, l:tempfile)
    execute 'source' fnameescape(l:tempfile)
  finally
    if filereadable(l:tempfile)
      call delete(l:tempfile)
    endif
  endtry
endfunction "}}}

" Set augroup "{{{
augroup MyAutoCmd
  autocmd!
  autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *?
        \ call vimrc#on_filetype()
augroup END
"}}}

" Initialize:
call s:source_rc('init.rc.vim')

" Dein:
call s:source_rc('dein.rc.vim')

" Encoding:
call s:source_rc('encoding.rc.vim')

" Options:
call s:source_rc('options.rc.vim')

" FileType:
call s:source_rc('filetype.rc.vim')

" Mappings:
call s:source_rc('mappings.rc.vim')

" Commands:
call s:source_rc('commands.rc.vim')

" Platform:
call s:source_rc('windows.rc.vim')
call s:source_rc('unix.rc.vim')
call s:source_rc('mac.rc.vim')
call s:source_rc('neovim.rc.vim')
call s:source_rc('gui.rc.vim')
call s:source_rc('cui.rc.vim')

set secure


" vim: foldmethod=marker fileencoding=utf-8
