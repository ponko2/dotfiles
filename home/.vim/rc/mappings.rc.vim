scriptencoding utf-8

"-------------------------------------------------------------------------------
" Key-mappings:
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Normal mode keymappings:

" 検索の強調表示を無効化
nnoremap <C-l> <Cmd>nohlsearch<CR><C-l>

" 引数リスト移動
nnoremap [a <Cmd>previous<CR>
nnoremap ]a <Cmd>next<CR>
nnoremap [A <Cmd>rewind<CR>
nnoremap ]A <Cmd>last<CR>

" バッファリスト移動
nnoremap [b <Cmd>bprevious<CR>
nnoremap ]b <Cmd>bnext<CR>
nnoremap [B <Cmd>brewind<CR>
nnoremap ]B <Cmd>blast<CR>

" ロケーションリスト移動
nnoremap [l <Cmd>lprevious<CR>
nnoremap ]l <Cmd>lnext<CR>
nnoremap [L <Cmd>lrewind<CR>
nnoremap ]L <Cmd>llast<CR>

" エラーリスト移動
nnoremap [q <Cmd>cprevious<CR>
nnoremap ]q <Cmd>cnext<CR>
nnoremap [Q <Cmd>lrewind<CR>
nnoremap ]Q <Cmd>clast<CR>

" タグリスト移動
nnoremap [t <Cmd>tprevious<CR>
nnoremap ]t <Cmd>tnext<CR>
nnoremap [T <Cmd>trewind<CR>
nnoremap ]T <Cmd>tlast<CR>

" Better x
nnoremap x "_x

" Better Y
nnoremap Y y$

" grep
nnoremap <Leader>/ :<C-u>Grep<Space>


"-------------------------------------------------------------------------------
" Command-line mode keymappings:

" Next history.
cnoremap <expr> <Down> pumvisible() ? "\<Down>" : "\<C-n>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<Down>"

" Previous history.
cnoremap <expr> <Up> pumvisible() ? "\<Up>" : "\<C-p>"
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<Up>"

" %% -> %:h/
cnoremap <expr> %% getcmdtype() ==# ':' ? expand('%:h') .. '/' : '%%'


"-------------------------------------------------------------------------------
" Visual mode keymappings:

" Disable dos-standard-mappings
silent! vunmap <C-x>


"-------------------------------------------------------------------------------
" Terminal keymappings:

if exists(':tnoremap')
  tnoremap <C-w> <C-\><C-n><C-w>
endif
