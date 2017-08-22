scriptencoding utf-8

"---------------------------------------------------------------------------
" Commands:
"

" Trim trailing whitespace
command! -range=% TrimTrailingWhitespace
      \ call <SID>TrimTrailingWhitespace(<line1>, <line2>)
function! s:TrimTrailingWhitespace(line1, line2) abort
  let l:view = winsaveview()
  execute 'keepjumps keeppatterns' a:line1 . ',' . a:line2 . 's/\s\+$//e'
  call winrestview(l:view)
endfunction

" Convert Samba Address
command! -range=% ConvertSambaAddress
      \ call <SID>ConvertSambaAddress(<line1>, <line2>)
function! s:ConvertSambaAddress(line1, line2) abort
  let l:view = winsaveview()
  execute 'keepjumps keeppatterns' a:line1 . ',' . a:line2 . 's/\\/\//g'
  execute 'keepjumps keeppatterns' a:line1 . ',' . a:line2 . 's/^/smb:/'
  call winrestview(l:view)
endfunction

" Rename file
command! -nargs=1 -bang -bar -complete=file Rename
      \ saveas<bang> <args> | call delete(expand('#:p'))

command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Latin
      \ edit<bang> ++enc=latin1 <args>

command! WUtf8 setlocal fenc=utf-8
command! WCp932 setlocal fenc=cp932
command! WLatin1 setlocal fenc=latin1

command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>


" vim: foldmethod=marker fileencoding=utf-8
