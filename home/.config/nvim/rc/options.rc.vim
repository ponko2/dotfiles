scriptencoding utf-8

"---------------------------------------------------------------------------
" Search:
"

" 大文字と小文字を無視する
set ignorecase

" 検索パターンが大文字を含んでいたらオプション ignorecase を無効にする
set smartcase

" インクリメンタルサーチを有効にする
set incsearch

" 検索パターンを強調表示
set hlsearch

" 検索がファイル末尾まで進んだらファイル先頭から再び検索する
set wrapscan


"---------------------------------------------------------------------------
" Edit:
"

" タブをスペースにする
set smarttab
set expandtab

" smart indentを有効にする
set autoindent
set smartindent

" タブ幅設定
set tabstop=2
set softtabstop=2
set shiftwidth=2

" インデントをshiftwidthの倍数に丸める
set shiftround

" 最終行への <EOL> 追加を無効化
set nofixendofline

" Disable modeline.
set modelines=0
set nomodeline

" クリップボードレジスタを使う
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" BackSpaceの挙動を設定
set backspace=indent,eol,start

" 対応する括弧の表示
set showmatch
set cpoptions& cpoptions-=m
set matchtime=3
set matchpairs& matchpairs+=<:>

if !exists('g:loaded_matchit') && !has('nvim')
  packadd! matchit
endif

" バッファが編集中でもその他のファイルを開けるように
set hidden

" 折り畳みの設定
set foldenable
set foldmethod=marker
set foldcolumn=1
set fillchars=vert:\|
set commentstring=%s

" :grep で使われるプログラムの指定
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --with-filename\ --smart-case
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" ファイル名やパス名に使われる文字の指定
set isfname& isfname-==

" タイムアウト設定
set timeout
set timeoutlen=3000
set ttimeoutlen=100

" スワップ設定
set swapfile
set updatetime=1000
if !isdirectory(expand('$XDG_DATA_HOME/nvim/swap'))
  call mkdir(expand('$XDG_DATA_HOME/nvim/swap'), 'p')
endif
set directory=$XDG_DATA_HOME/nvim/swap

" バックアップ設定
set backup
set writebackup
if !isdirectory(expand('$XDG_DATA_HOME/nvim/backup'))
  call mkdir(expand('$XDG_DATA_HOME/nvim/backup'), 'p')
endif
set backupdir=$XDG_DATA_HOME/nvim/backup

" vimを終了してもundo履歴を復元する
set undofile
if !isdirectory(expand('$XDG_DATA_HOME/nvim/undo'))
  call mkdir(expand('$XDG_DATA_HOME/nvim/undo'), 'p')
endif
set undodir=$XDG_DATA_HOME/nvim/undo

" Visual blockモードで仮想編集を有効にする
set virtualedit=block

" K コマンドに使われるプログラムの設定
set keywordprg=:help

" Vimの外部で変更を受けたバッファがないかどうか調べる
autocmd MyAutoCmd WinEnter * checktime

" Disable paste.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Update diff.
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

" Make directory automatically.
autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" Use autofmt.
set formatexpr=autofmt#japanese#formatexpr()


"---------------------------------------------------------------------------
" View:
"

" 文字幅が曖昧な文字を全角表示
set ambiwidth=double

" 特殊文字を可視化
set list
if IsWindows()
  set listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
endif

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

" Enable tabline.
set showtabline=1

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
set nowrap
if exists('+breakindent')
  set breakindent
endif

" Do not display greetings message at the time of Vim start.
set shortmess=aTI

" ベルを無効にする
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

" 補完定設
set completeopt=menuone
set completeopt+=noinsert
set completeopt+=noselect

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
if !isdirectory(expand('$XDG_DATA_HOME/nvim/view'))
  call mkdir(expand('$XDG_DATA_HOME/nvim/view'), 'p')
endif
set viewdir=$XDG_DATA_HOME/nvim/view
set viewoptions& viewoptions-=options viewoptions+=slash,unix

" 指定した列を強調表示
set conceallevel=2
set concealcursor=niv
set colorcolumn=119

" 終了時の情報を保存
if !has('nvim')
  set viminfo& viminfo+=n$XDG_DATA_HOME/nvim/viminfo
endif

" Color Scheme: "{{{

" Enable 256 color terminal.
set t_Co=256

if !exists('g:colors_name')
  if IsWindows()
    " 斜体表示をしない
    let g:gruvbox_italic = 0
  endif

  try
    set background=dark
    colorscheme gruvbox
  catch
    colorscheme desert
  endtry
endif

"}}}


"---------------------------------------------------------------------------
" Others:
"

" 日本語ヘルプを優先
set helplang& helplang=ja,en

" Don't calc octal.
set nrformats& nrformats-=octal

" Default home directory.
let t:cwd = getcwd()

" Input Japanese: "{{{

if has('multi_byte_ime') || has('xim')
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


" vim: foldmethod=marker fileencoding=utf-8
