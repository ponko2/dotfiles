"---------------------------------------------------------------------------
" neosnippet.vim
"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#expand_word_boundary = 1
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" Plugin key-mappings. "{{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" }}}


" vim: foldmethod=marker fileencoding=utf-8
