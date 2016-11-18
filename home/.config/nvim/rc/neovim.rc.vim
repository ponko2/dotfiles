scriptencoding utf-8

if !has('nvim') | finish | endif

"---------------------------------------------------------------------------
" Neovim:
"

" Enable true color
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1

" Use cursor shape feature
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

if has('vim_starting')
  syntax off
endif

" Share the histories
autocmd MyAutoCmd CursorHold * if exists(':rshada') | rshada | wshada | endif

" Terminal setting.
command! -bang Terminal terminal<bang> $SHELL
tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> <C-w><C-h> <C-\><C-n><C-w><C-h>
tnoremap <silent> <C-w><C-j> <C-\><C-n><C-w><C-j>
tnoremap <silent> <C-w><C-k> <C-\><C-n><C-w><C-k>
tnoremap <silent> <C-w><C-l> <C-\><C-n><C-w><C-l>
tnoremap <silent> <C-w><C-w> <C-\><C-n><C-w><C-w>
tnoremap <silent> <C-w>h <C-\><C-n><C-w>h
tnoremap <silent> <C-w>j <C-\><C-n><C-w>j
tnoremap <silent> <C-w>k <C-\><C-n><C-w>k
tnoremap <silent> <C-w>l <C-\><C-n><C-w>l
tnoremap <silent> <C-w>w <C-\><C-n><C-w>w
nnoremap <silent> <Leader>s :<C-u>belowright 10split term://$SHELL<CR>
autocmd MyAutoCmd BufWinEnter,WinEnter term://* startinsert
autocmd MyAutoCmd BufLeave term://* stopinsert


" vim: foldmethod=marker fileencoding=utf-8
