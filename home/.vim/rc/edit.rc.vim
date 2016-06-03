scriptencoding utf-8

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

" modelineを使う
set modeline

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
packadd matchit

" バッファが編集中でもその他のファイルを開けるように
set hidden

" 開いているファイルが他で編集されたら読み直す
"set autoread

" Insertモードでの単語補完時にもignorecase
set infercase

" :cd や :lcd を使ったときに検索されるディレクトリの設定
"set cdpath& cdpath+=~

" 折り畳みの設定
set foldenable
set foldmethod=marker
set foldcolumn=1
set fillchars=vert:\|
set commentstring=%s

" :grep で使われるプログラムの指定
if executable('ag')
  set grepprg=ag\ --smart-case\ --vimgrep
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -inH
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
set directory=~/.vim/tmp

" バックアップ設定
set backup
set writebackup
set backupdir=~/.vim/tmp

" vimを終了してもundo履歴を復元する
if v:version >= 703
  set undofile
  set undodir=~/.vim/undo
endif

" tagの設定
if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  set notagbsearch
endif

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


" vim: foldmethod=marker fileencoding=utf-8
