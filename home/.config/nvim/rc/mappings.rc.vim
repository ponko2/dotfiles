scriptencoding utf-8

"---------------------------------------------------------------------------
" Key-mappings:
"

"---------------------------------------------------------------------------
" Normal mode keymappings:

" 検索の強調表示を無効化
nnoremap <silent> <C-l> <Cmd>nohlsearch<CR><C-l>

" 引数リスト移動
nnoremap <silent> [a <Cmd>previous<CR>
nnoremap <silent> ]a <Cmd>next<CR>
nnoremap <silent> [A <Cmd>first<CR>
nnoremap <silent> ]A <Cmd>last<CR>

" バッファリスト移動
nnoremap <silent> [b <Cmd>bprevious<CR>
nnoremap <silent> ]b <Cmd>bnext<CR>
nnoremap <silent> [B <Cmd>bfirst<CR>
nnoremap <silent> ]B <Cmd>blast<CR>

" ロケーションリスト移動
function! s:Lprevious() abort
  try
    lprevious
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  catch
    echo v:exception
  endtry
endfunction
function! s:Lnext() abort
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  catch
    echo v:exception
  endtry
endfunction
nnoremap <silent> [l <Cmd>call <SID>Lprevious()<CR>
nnoremap <silent> ]l <Cmd>call <SID>Lnext()<CR>
nnoremap <silent> [L <Cmd>lfirst<CR>
nnoremap <silent> ]L <Cmd>llast<CR>

" エラーリスト移動
function! s:Cprevious() abort
  try
    cprevious
  catch /^Vim\%((\a\+)\)\=:E553/
    clast
  catch
    echo v:exception
  endtry
endfunction
function! s:Cnext() abort
  try
    cnext
  catch /^Vim\%((\a\+)\)\=:E553/
    cfirst
  catch
    echo v:exception
  endtry
endfunction
nnoremap <silent> [q <Cmd>call <SID>Cprevious()<CR>
nnoremap <silent> ]q <Cmd>call <SID>Cnext()<CR>
nnoremap <silent> [Q <Cmd>cfirst<CR>
nnoremap <silent> ]Q <Cmd>clast<CR>

" タグリスト移動
nnoremap <silent> [t <Cmd>tprevious<CR>
nnoremap <silent> ]t <Cmd>tnext<CR>
nnoremap <silent> [T <Cmd>tfirst<CR>
nnoremap <silent> ]T <Cmd>tlast<CR>

" Better n
nnoremap <silent> n <Cmd>execute 'normal!' v:count1 . 'nzvzz'<CR>
nnoremap <silent> N <Cmd>execute 'normal!' v:count1 . 'Nzvzz'<CR>

" Better x
nnoremap x "_x

" Better Y
nnoremap Y y$

" grep
nnoremap <Leader>/ :<C-u>Grep<Space>


"---------------------------------------------------------------------------
" Command-line mode keymappings:

" Next history.
cnoremap <expr> <Down> pumvisible() ? "\<Down>" : "\<C-n>"
cnoremap <expr> <C-n> pumvisible() ? "\<C-n>" : "\<Down>"

" Previous history.
cnoremap <expr> <Up> pumvisible() ? "\<Up>" : "\<C-p>"
cnoremap <expr> <C-p> pumvisible() ? "\<C-p>" : "\<Up>"

" %% -> %:h/
cnoremap <expr> %% getcmdtype() ==# ':' ? expand('%:h').'/' : '%%'


"---------------------------------------------------------------------------
" Visual mode keymappings:

" Disable dos-standard-mappings
silent! vunmap <C-x>


"---------------------------------------------------------------------------
" Terminal keymappings:

if exists(':tnoremap')
  tnoremap <C-w> <C-\><C-n><C-w>
endif
