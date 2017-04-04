scriptencoding utf-8

"---------------------------------------------------------------------------
" Key-mappings:
"

" Normal mode keymappings: "{{{
" 検索の強調表示を無効化
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" 引数リスト移動
nnoremap <silent> [a :<C-u>previous<CR>
nnoremap <silent> ]a :<C-u>next<CR>
nnoremap <silent> [A :<C-u>first<CR>
nnoremap <silent> ]A :<C-u>last<CR>

" バッファリスト移動
nnoremap <silent> [b :<C-u>bprevious<CR>
nnoremap <silent> ]b :<C-u>bnext<CR>
nnoremap <silent> [B :<C-u>bfirst<CR>
nnoremap <silent> ]B :<C-u>blast<CR>

" ロケーションリスト移動
nnoremap <silent> [l :<C-u>lprevious<CR>
nnoremap <silent> ]l :<C-u>lnext<CR>
nnoremap <silent> [L :<C-u>lfirst<CR>
nnoremap <silent> ]L :<C-u>llast<CR>

" エラーリスト移動
nnoremap <silent> [q :<C-u>cprevious<CR>
nnoremap <silent> ]q :<C-u>cnext<CR>
nnoremap <silent> [Q :<C-u>cfirst<CR>
nnoremap <silent> ]Q :<C-u>clast<CR>

" タグリスト移動
nnoremap <silent> [t :<C-u>tprevious<CR>
nnoremap <silent> ]t :<C-u>tnext<CR>
nnoremap <silent> [T :<C-u>tfirst<CR>
nnoremap <silent> ]T :<C-u>tlast<CR>

" Better x
nnoremap x "_x
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
" %% -> %:h/
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
"}}}

" Visual mode keymappings: "{{{
" Disable dos-standard-mappings
silent! vunmap <C-x>
"}}}


" vim: foldmethod=marker fileencoding=utf-8
