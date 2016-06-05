scriptencoding utf-8

"---------------------------------------------------------------------------
" View:
"

" 特殊文字を可視化
set list
if IsWindows()
  set listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
endif
augroup HighlightIdegraphicSpace
  autocmd!
  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGray guibg=DarkGray
  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

" 最下ウィンドウにいつステータス行を常に表示
set laststatus=2

" コマンドラインに使われる画面上の行数を設定
set cmdheight=2

" 入力中のコマンドを表示
set showcmd

" タイトルを表示する
set title

" ウィンドウタイトルが占める列の割合(パーセント)
set titlelen=95

" Disable tabline.
set showtabline=0

" Set statusline.
let &g:statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
      \ . ".(winnr('#')==winnr()?'#':'').']':''}\ "
      \ . "%{(&previewwindow?'[preview] ':'').expand('%:t')}"
      \ . "\ %=%{(winnr('$')==1 || winnr('#')!=winnr()) ?
      \ '['.(&filetype!=''?&filetype.',':'')"
      \ . ".(&fenc!=''?&fenc:&enc).','.&ff.']' : ''}"
      \ . "%m%{printf('%'.(len(line('$'))+2).'d/%d',line('.'),line('$'))}"

" 折り返し表示の設定
set linebreak
set showbreak=\
set breakat=\ \	;:,!?

" 折り返し設定
set whichwrap& whichwrap+=h,l,<,>,[,],b,s,~
if exists('+breakindent')
  set breakindent
  set wrap
else
  set nowrap
endif

" Do not display greetings message at the time of Vim start.
set shortmess=aTI

" ベルを無効にする
set t_vb=
set novisualbell
set belloff=all

" コマンドライン補完
set nowildmenu
set wildmode=list:longest,full

" コマンドと以前に使った検索パターン履歴の保存個数
set history=1000

" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag

" Can supplement a tag in a command-line.
set wildoptions=tagfile

" Disable menu
let g:did_install_default_menus = 1

if !&verbose
  " US英語の時スペルチェックを有効にする
  set spelllang=en_us

  " スペルチェックから日本語を除外
  set spelllang+=cjk
endif

" 補完候補が1つしかないときもポップアップメニューを使う
set completeopt=menuone

" キーワード補完の対象を設定
set complete=.

" 補完のポップアップメニュー最大表示件数
set pumheight=20

" 変更された行の数を報告
set report=0

" Maintain a current line at the time of movement as much as possible.
set nostartofline

" ウィンドウを横分割した際、新しいウィンドウはカレントウィンドウの下に開く
set splitbelow

" ウィンドウを縦分割した際、新しいウィンドウはカレントウィンドウの右に開く
set splitright

" カレントウィンドウではないウィンドウの幅の最小値
set winwidth=30

" カレントウィンドウの行数の最小値
set winheight=1

" コマンドライン・ウィンドウに使われる画面上の行数
set cmdwinheight=5

" ウィンドウを分割したり閉じたりした時、全てのウィンドウを自動的に同じサイズにしない
set noequalalways

" プレビューウィンドウの高さの設定
set previewheight=8

" コマンド :help で開かれたヘルプウィンドウの、開始時のウィンドウ高の最小値を設定
set helpheight=12

" キーボードから打ち込まれないコマンドを実行する間、画面を再描画しない
set lazyredraw

" ターミナル接続を高速にする
set ttyfast

" 最後の行が収まりきらない時 @ と表示しない
set display=lastline

" View setting.
set viewdir=~/.vim/view
set viewoptions& viewoptions-=options viewoptions+=slash,unix

" 指定した列を強調表示
if has('conceal')
  " For conceal.
  set conceallevel=2
  set concealcursor=niv

  set colorcolumn=120
endif

" 終了時の情報を保存
set viminfo& viminfo+=n~/.vim/tmp/viminfo


" vim: foldmethod=marker fileencoding=utf-8
