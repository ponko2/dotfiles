scriptencoding utf-8

"---------------------------------------------------------------------------
" Commands:
"

" Trim trailing whitespace
command! -range=% TrimTrailingWhitespace <line1>,<line2>s/\s\+$//e

" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>

" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

" Rename file
command! -nargs=1 -bang -bar -complete=file Rename saveas<bang> <args> | call delete(expand('#:p'))


" vim: foldmethod=marker fileencoding=utf-8
