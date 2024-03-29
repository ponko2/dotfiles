scriptencoding utf-8

"---------------------------------------------------------------------------
" Commands:
"

" grep
command! -nargs=+ Grep execute 'silent grep! <args>' | redraw!
command! -nargs=+ GrepAdd execute 'silent grepadd! <args>' | redraw!

" Trim trailing whitespace
command! -range=% TrimTrailingWhitespace
      \ call s:TrimTrailingWhitespace(<line1>, <line2>)
function! s:TrimTrailingWhitespace(line1, line2) abort
  let l:view = winsaveview()
  execute 'keepjumps keeppatterns' a:line1 .. ',' .. a:line2 .. 's/[[:space:]　]\+$//e'
  call winrestview(l:view)
endfunction

" Convert Samba Address
command! -range=% ConvertSambaAddress
      \ call s:ConvertSambaAddress(<line1>, <line2>)
function! s:ConvertSambaAddress(line1, line2) abort
  let l:view = winsaveview()
  execute 'keepjumps keeppatterns' a:line1 .. ',' .. a:line2 .. 's/\\/\//g'
  execute 'keepjumps keeppatterns' a:line1 .. ',' .. a:line2 .. 's/^/smb:/'
  call winrestview(l:view)
endfunction

" Rename file
command! -nargs=1 -bang -bar -complete=file Rename
      \ saveas<bang> <args> | call delete(expand('#:p'))

command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>

command! WUtf8 setlocal fenc=utf-8
command! WCp932 setlocal fenc=cp932

command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>
