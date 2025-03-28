scriptencoding utf-8

"-------------------------------------------------------------------------------
" Options:
"-------------------------------------------------------------------------------


"-------------------------------------------------------------------------------
" Search:

" 大文字と小文字を無視する
set ignorecase

" 検索パターンが大文字を含んでいたらオプション ignorecase を無効にする
set smartcase

" インクリメンタルサーチを有効にする
set incsearch

" 検索パターンを強調表示
set hlsearch


"-------------------------------------------------------------------------------
" Edit:

" ファイルの変更を検知してバッファを再読み込み
set autoread

" タブをスペースにする
set smarttab
set expandtab

" smart indentを有効にする
set autoindent
set smartindent

" インデントをshiftwidthの倍数に丸める
set shiftround

" 最終行への <EOL> 追加を無効化
set nofixendofline

" クリップボードレジスタを使う
if has('unnamedplus')
  set clipboard& clipboard^=unnamedplus
else
  set clipboard& clipboard^=unnamed
endif

" BackSpaceの挙動を設定
set backspace=indent,eol,nostop

" 対応する括弧の表示
set showmatch

if !exists('g:loaded_matchit')
  packadd! matchit
endif

" バッファが編集中でもその他のファイルを開けるように
set hidden

" :grep で使われるプログラムの指定
if executable('rg')
  set grepprg=rg\ --vimgrep\ -uu
  set grepformat=%f:%l:%c:%m
endif

" スワップ設定
if !has('nvim')
  if !isdirectory(expand('$XDG_DATA_HOME/vim/swap'))
    call mkdir(expand('$XDG_DATA_HOME/vim/swap'), 'p')
  endif
  set directory=$XDG_DATA_HOME/vim/swap
endif

" バックアップ設定
set backup
set backupdir-=.
if !has('nvim')
  if !isdirectory(expand('$XDG_DATA_HOME/vim/backup'))
    call mkdir(expand('$XDG_DATA_HOME/vim/backup'), 'p')
  endif
  set backupdir=$XDG_DATA_HOME/vim/backup
endif

" vimを終了してもundo履歴を復元する
set undofile
if !has('nvim')
  if !isdirectory(expand('$XDG_DATA_HOME/vim/undo'))
    call mkdir(expand('$XDG_DATA_HOME/vim/undo'), 'p')
  endif
  set undodir=$XDG_DATA_HOME/vim/undo
endif

" Visual blockモードで仮想編集を有効にする
set virtualedit=block


"-------------------------------------------------------------------------------
" View:

" 特殊文字を可視化
set list
if &encoding ==# 'utf-8'
  set listchars=tab:￫\ ,multispace:･,lead:･,trail:･,nbsp:+
else
  set listchars=tab:>\ ,multispace:-,lead:-,trail:-,nbsp:+
endif

" 最下ウィンドウにステータス行を常に表示
set laststatus=2

" 入力中のコマンドを表示
set showcmd

" タイトルを表示する
set title

" Set statusline.
let &g:statusline = "%{winnr('$') > 1 ? '[' .. winnr() .. '/' .. winnr('$')"
      \ .. " .. (winnr('#') ==# winnr() ? '#' : '') .. ']' : ''} "
      \ .. "%{(&previewwindow ? '[Preview] ' : '') .. expand('%:t')} "
      \ .. "%=%{(winnr('$') ==# 1 || winnr('#') !=# winnr()) ? "
      \ .. "'[' .. (&filetype !=# '' ? &filetype .. ',' : '')"
      \ .. " .. (&fenc !=# '' ? &fenc : &enc) .. ',' .. &ff .. ']' : ''}"
      \ .. "%m%{printf('%' .. (len(line('$')) + 2) .. 'd/%d', line('.'), line('$'))}"

" 折り返し表示の設定
set linebreak
set showbreak=>\ 

" 折り返し設定
set whichwrap& whichwrap+=b,s,h,l,<,>,~,[,]
set nowrap
set breakindent

" ベルを無効にする
set belloff=all

" コマンドライン補完
set wildignorecase
set wildoptions& wildoptions+=pum,tagfile,fuzzy

" コマンドと以前に使った検索パターン履歴の保存個数
set history=10000

" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag

" Disable menu
let g:did_install_default_menus = 1

if !&verbose
  " US英語のスペルチェックを有効化
  set spelllang-=en
  set spelllang+=en_us

  " スペルチェックから日本語を除外
  set spelllang+=cjk
endif

" 補完定設
set completeopt-=menu
set completeopt^=menu,menuone
set completeopt+=noselect
if exists('+completepopup')
  set completeopt+=popup
  set completepopup=height:10,width:60,highlight:InfoPopup
endif

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

" ウィンドウを分割したり閉じたりした時、全てのウィンドウを自動的に同じサイズにしない
set noequalalways

" 最後の行が収まりきらない時 @ と表示しない
set display=lastline

" View setting.
if !has('nvim')
  if !isdirectory(expand('$XDG_DATA_HOME/vim/view'))
    call mkdir(expand('$XDG_DATA_HOME/vim/view'), 'p')
  endif
  set viewdir=$XDG_DATA_HOME/vim/view
endif
set viewoptions& viewoptions-=options viewoptions+=slash,unix

" Conceal表示
set concealcursor=nc
set conceallevel=2

" 指定した列を強調表示
set colorcolumn=119

" 終了時の情報を保存
if !has('nvim')
  set viminfo& viminfo+=n$XDG_DATA_HOME/vim/viminfo
endif

" Enable true color
if exists('+termguicolors')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if exists('+previewpopup')
  set previewpopup=height:10,width:60
endif

if exists('&pumblend')
  set pumblend=20
endif

if exists('&winblend')
  set winblend=20
endif


"-------------------------------------------------------------------------------
" Others:

" Don't calc octal.
set nrformats& nrformats-=octal nrformats+=unsigned
