"---------------------------------------------------------------------------
" neosnippet.vim
"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1
let g:neosnippet#enable_conceal_markers = 0
let g:neosnippet#snippets_directory = expand('$XDG_CONFIG_HOME/nvim/snippets')

autocmd MyAutoCmd CompleteDone * call neosnippet#complete_done()


"---------------------------------------------------------------------------
" Plugin key-mappings:

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)


" vim: fileencoding=utf-8
