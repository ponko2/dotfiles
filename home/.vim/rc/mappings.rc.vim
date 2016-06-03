scriptencoding utf-8

"---------------------------------------------------------------------------
" Key-mappings:
"

" Normal mode keymappings: "{{{
" 検索の強調表示を無効化
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"}}}

" Command-line mode keymappings: "{{{
" <C-a>, A: move to head.
cnoremap <C-a> <Home>
" <C-b>: previous char.
cnoremap <C-b> <Left>
" <C-d>: delete char.
cnoremap <C-d> <Del>
" <C-e>, E: move to end.
cnoremap <C-e> <End>
" <C-f>: next char.
cnoremap <C-f> <Right>
" <C-n>: next history.
cnoremap <C-n> <Down>
" <C-p>: previous history.
cnoremap <C-p> <Up>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>
" <C-y>: paste.
cnoremap <C-y> <C-r>*
" <C-g>: Exit.
cnoremap <C-g> <C-c>

" Auto escape / and ? in search command.
"cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
"cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
"}}}


" vim: foldmethod=marker fileencoding=utf-8
