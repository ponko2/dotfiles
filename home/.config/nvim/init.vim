scriptencoding utf-8

" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

" Enable no Vi compatible commands "{{{
if &compatible
  set nocompatible
endif
"}}}

if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = expand('~/.config')
endif

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = expand('~/.cache')
endif

function! s:source_rc(path, ...) abort "{{{
  let use_global = get(a:000, 0, !has('vim_starting'))
  let abspath = resolve(expand('$XDG_CONFIG_HOME/nvim/rc/' . a:path))

  if !use_global
    execute 'source' fnameescape(abspath)
    return
  endif

  " substitute all 'set' to 'setglobal'
  let content = map(readfile(abspath),
        \ 'substitute(v:val, "^\\W*\\zsset\\ze\\W", "setglobal", "")')

  " create tempfile and source the tempfile
  let tempfile = tempname()

  try
    call writefile(content, tempfile)
    execute printf('source %s', fnameescape(tempfile))
  finally
    if filereadable(tempfile)
      call delete(tempfile)
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
