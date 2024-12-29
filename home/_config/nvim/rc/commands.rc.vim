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
