scriptencoding utf-8

"-------------------------------------------------------------------------------
" Autocmds:
"-------------------------------------------------------------------------------

" Create augroup
augroup MyAutoCmd
  autocmd!
augroup END

" ファイルの変更を検知してバッファを再読み込み
autocmd MyAutoCmd FocusGained,WinEnter,CursorHold,CursorHoldI *
      \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd MyAutoCmd FileChangedShellPost *
      \ echohl WarningMsg | echomsg "File changed on disk. Buffer reloaded." | echohl None

" quickfixウィンドウを自動で開く
autocmd MyAutoCmd QuickFixCmdPost make,grep,grepadd,vimgrep tab cwindow

" Disable paste.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Update diff.
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

" Make directory automatically.
autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype ==# '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]: ',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" コメントの自動挿入をしない
autocmd MyAutoCmd FileType,Syntax,BufEnter,BufWinEnter *
      \ setlocal formatoptions-=r formatoptions-=o formatoptions+=mM
