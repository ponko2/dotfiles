scriptencoding utf-8

if !IsGUI() | finish | endif

"---------------------------------------------------------------------------
" GUI:
"

"---------------------------------------------------------------------------
" Font:

if IsWindows()
  set guifont=MS_Gothic:h12:cSHIFTJIS
  set guifontwide=MS_Gothic:h12:cSHIFTJIS
  set renderoptions=type:directx

  " 行間隔の設定
  set linespace=1

  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif IsMac()
  set guifont=Ricty\ Diminished\ Regular:h18
  set guifontwide=Ricty\ Diminished\ Regular:h18
else
  set guifont=Ricty\ 12
  set guifontwide=Ricty\ 12
endif


"---------------------------------------------------------------------------
" Window:

" Width of window.
if &columns < 170
   set columns=170
endif

" Height of window.
if &lines < 40
   set lines=40
endif


"---------------------------------------------------------------------------
" Mouse:

" どのモードでもマウスを使えるようにする
set mouse=a

" 右クリックで選択範囲を広げる
set mousemodel=extend

" マウスの移動でフォーカスを自動的に切替えない
set nomousefocus

" 入力時にマウスポインタを隠す
set mousehide


"---------------------------------------------------------------------------
" Menu:

" Hide toolbar and menus.
set guioptions-=T
set guioptions-=m

" Scrollbar is always off.
set guioptions-=rL

" Not guitablabel.
set guioptions-=e

" Confirm without window.
set guioptions+=c

if has('patch-8.0.1609')
  set guioptions+=!
endif


"---------------------------------------------------------------------------
" View:

" Don't flick cursor.
set guicursor& guicursor+=a:blinkon0
