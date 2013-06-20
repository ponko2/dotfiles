" Initialize: "{{{

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))

"}}}

" Fonts:"{{{

set ambiwidth=double

if s:is_windows
  " Number of pixel lines inserted between characters.
  set linespace=2

  if has('kaoriya')
    set ambiwidth=auto
  endif

  set guifont=Ricty:h12
  set guifontwide=Ricty:h12
elseif has('mac')
  set guifont=Andale\ Mono:h18
  set guifontwide=ヒラギノ丸ゴ\ ProN\ W4:h18
else
  set guifont=Ricty\ 12
  set guifontwide=Ricty\ 12
endif

"}}}

" Window:"{{{

" Save the setting of window. "{{{
let g:save_window_file = expand('~/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
          \ 'set columns=' . &columns,
          \ 'set lines=' . &lines,
          \ 'winpos ' . getwinposx() . ' ' . getwinposy(),
          \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END

if has('vim_starting') && filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif

" Setting of colorscheme.
" Don't override colorscheme.
if !exists('g:colors_name') || g:colors_name == 'macvim'
  colorscheme xoria256
endif
"}}}

"}}}

" Mouse:"{{{

" 右クリックで選択範囲を広げる
set mousemodel=extend

" マウスカーソルのおかれたウィンドウをアクティブにする
set nomousefocus

" 文字が入力されるときにはマウスカーソルを隠す
set mousehide

" 貼り付け
nnoremap <RightMouse> "+p
xnoremap <RightMouse> "+p
nnoremap <RightMouse> <C-r><C-o>+
cnoremap <RightMouse> <C-r>+

"}}}

" Menu:"{{{

" Hide toolbar and menus.
set guioptions-=T
set guioptions-=m

" Scrollbar is always off.
set guioptions-=rL

" Not guitablabel.
set guioptions-=e

" fullscreen "{{{
nnoremap <silent> <F11> :<C-u>call <SID>toggle_full_secreen()<CR>
function! s:toggle_full_secreen()
  if &guioptions =~# 'C'
    set guioptions-=C
    if exists('s:go_temp')
      if s:go_temp =~# 'm'
        set guioptions+=m
      endif
      if s:go_temp =~# 'T'
        set guioptions+=T
      endif
    endif
    if s:is_windows
      simalt ~r
    endif

    let [&lines, &columns] = [s:lines_save, s:columns_save]
  else
    let s:go_temp = &guioptions
    set guioptions+=C
    set guioptions-=m
    set guioptions-=T
    if s:is_windows
      simalt ~x
    endif

    let [s:lines_save, s:columns_save] = [&lines, &columns]

    set columns=999
    set lines=999
  endif
endfunction
"}}}

" Confirm without window.
set guioptions+=c

"}}}

" Views:"{{{

" Don't highlight search result.
set nohlsearch

" Disable bell.
set vb t_vb=

" Don't flick cursor.
set guicursor&
set guicursor+=a:blinkon0

"}}}

" Platform depends:"{{{

" 日本語入力に関する設定 "{{{
if has('multi_byte_ime') || has('xim') || has('gui_macvim')
  " IME ON時のカーソルの色を設定
  highlight CursorIM guibg=Purple guifg=NONE
  " 挿入モード・検索モードでのデフォルトのIME状態設定
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    " XIMの入力開始キーを設定
    set imactivatekey=s-space
  endif
  " 挿入モードでのIME状態を記憶させない
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

if has('gui_macvim') && has('kaoriya')
  set noimdisable
  set imdisableactivate
endif
"}}}

"}}}

" vim: foldmethod=marker fileencoding=utf8