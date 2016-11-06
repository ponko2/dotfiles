scriptencoding utf-8

if !has('gui_running') | finish | endif

"---------------------------------------------------------------------------
" GUI:
"

" Font: "{{{

set ambiwidth=double

if IsWindows()
  set guifont=MS_Gothic:h12:cSHIFTJIS
  set guifontwide=MS_Gothic:h12:cSHIFTJIS
  set renderoptions=type:directx

  " 行間隔の設定
  set linespace=1

  " 斜体表示をしない
  let g:gruvbox_italic = 0

  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif IsMac()
  set guifont=Ricty:h18
  set guifontwide=Ricty:h18
else
  set guifont=Ricty\ 12
  set guifontwide=Ricty\ 12
endif

"}}}

" Window: "{{{

" Width of window.
if &columns < 170
   set columns=170
endif

" Height of window.
if &lines < 40
   set lines=40
endif

"}}}

" Input Japanese: "{{{

if has('multi_byte_ime') || has('xim') || has('gui_macvim')
  " IME ON時のカーソルの色を設定
  autocmd MyAutoCmd ColorScheme * highlight CursorIM guibg=Purple guifg=NONE

  " 挿入モードでのデフォルトIME状態
  set iminsert=0

  " 検索モードでのデフォルトIME状態
  set imsearch=0

  " 挿入モードでのIME状態を記憶させない
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

if has('gui_macvim') && has('kaoriya')
  set noimdisable
  set imdisableactivate
endif

"}}}

" Mouse: "{{{

" どのモードでもマウスを使えるようにする
set mouse=a

" 右クリックで選択範囲を広げる
set mousemodel=extend

" マウスの移動でフォーカスを自動的に切替えない
set nomousefocus

" 入力時にマウスポインタを隠す
set mousehide

"}}}

" Menu: "{{{

" Hide toolbar and menus.
set guioptions-=T
set guioptions-=m

" Scrollbar is always off.
set guioptions-=rL

" Not guitablabel.
set guioptions-=e

" Confirm without window.
set guioptions+=c

"}}}

" View: "{{{

" Don't flick cursor.
set guicursor& guicursor+=a:blinkon0

"}}}

" Color Scheme: "{{{

if !exists('g:colors_name')
  set background=dark
  try
    colorscheme gruvbox
  catch
    colorscheme desert
  endtry
endif

"}}}


" vim: foldmethod=marker fileencoding=utf-8
