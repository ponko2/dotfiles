scriptencoding utf-8

"---------------------------------------------------------------------------
" Encoding:
"

" When do not include Japanese, use encoding for fileencoding.
function! s:ReCheck_FENC() abort
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction
autocmd MyAutoCmd BufReadPost * call s:ReCheck_FENC()

" Default fileformat.
set fileformat=unix

" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac


" vim: foldmethod=marker fileencoding=utf-8
