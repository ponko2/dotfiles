"---------------------------------------------------------------------------
" neocomplete.vim
"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" Plugin key-mappings. "{{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets' behavior.
"imap <expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ neosnippet#expandable_or_jumpable() ?
"      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"smap <expr> <TAB>
"      \ neosnippet#expandable_or_jumpable() ?
"      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"}}}


" vim: foldmethod=marker fileencoding=utf-8
