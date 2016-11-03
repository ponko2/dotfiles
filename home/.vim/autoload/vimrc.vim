"---------------------------------------------------------------------------
" vimrc functions:
"

function! vimrc#on_filetype() abort "{{{
  if execute('filetype') =~# 'OFF'
    " Lazy loading
    silent! filetype plugin indent on
    filetype detect
    syntax enable

    " gitgutter highlight
    doautocmd ColorScheme
  endif
endfunction "}}}
