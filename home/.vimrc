" Initialize: "{{{

" Enable no Vi compatible commands.
set nocompatible

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_mac = !s:is_windows && !s:is_cygwin
      \ && (has('mac') || has('macunix') || has('gui_macvim') ||
      \   (!executable('xdg-open') &&
      \     system('uname') =~? '^darwin'))

" Use English interface.
if s:is_windows
  language message en
else
  language message C
endif

" <Leader>を,に変更
let mapleader = ','
let g:mapleader = ','
let g:maplocalleader = 'm'

nnoremap ; <Nop>
xnoremap ; <Nop>
nnoremap m <Nop>
xnoremap m <Nop>
nnoremap , <Nop>
xnoremap , <Nop>

" prefix key. {{{
nmap <Space> [Space]
xmap <Space> [Space]
nnoremap [Space] <Nop>
xnoremap [Space] <Nop>

nmap s [Window]
nnoremap [Window] <Nop>

nmap e [Alt]
xmap e [Alt]
nnoremap [Alt]e e
xnoremap [Alt]e e
nnoremap [Alt] <Nop>
xnoremap [Alt] <Nop>

nmap q [Quickfix]
nnoremap [Quickfix] <Nop>

nmap t [Tag]
nnoremap [Tag] <Nop>
" }}}

if s:is_windows
  set shellslash
endif

let $DOTVIM = expand('~/.vim')

if !exists($MYGVIMRC)
  let $MYGVIMRC = expand('~/.gvimrc')
endif

" Functions: "{{{

" Anywhere SID. "{{{
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
"}}}

function! s:set_default(var, val) "{{{
  if !exists(a:var) || type({a:var}) != type(a:val)
    silent! unlet {a:var}
    let {a:var} = a:val
  endif
endfunction
"}}}

function! s:check_back_space() "{{{
   let col = col('.') - 1
   return !col || getline('.')[col - 1] =~ '\s'
endfunction
"}}}

"}}}

" Set augroup.
augroup MyAutoCmd
  autocmd!
augroup END

filetype off

let s:neobundle_dir = expand('~/.vim/bundle')

if has('vim_starting') "{{{
  " Set runtimepath.
  if s:is_windows
    let &runtimepath = join([
          \ expand('~/.vim'),
          \ expand('$VIM/runtime'),
          \ expand('~/.vim/after')], ',')
  endif

  " Load neobundle.
  if isdirectory('neobundle.vim')
    set runtimepath+=neobundle.vim
  elseif finddir('neobundle.vim', '.;') != ''
    execute 'set runtimepath+=' . finddir('neobundle.vim', '.;')
  elseif &runtimepath !~ '/neobundle.vim'
    if !isdirectory(s:neobundle_dir.'/neobundle.vim')
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ s:neobundle_dir.'/neobundle.vim'
    endif

    execute 'set runtimepath+=' . s:neobundle_dir.'/neobundle.vim'
  endif
endif
"}}}

let g:neobundle#enable_tail_path = 1
let g:neobundle#default_options = {
      \ 'default' : { 'overwrite' : 0 },
      \ }

call neobundle#rc(s:neobundle_dir)

" neobundle.vim "{{{

NeoBundleFetch 'Shougo/neobundle.vim', '', 'default'

NeoBundle 'Shougo/vimproc', '', 'default', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

" unite.vim "{{{
NeoBundleLazy 'Shougo/unite.vim', '', 'default', {
      \ 'autoload' : {
      \   'commands' : [
      \     {
      \       'name' : 'Unite',
      \       'complete' : 'customlist,unite#complete_source'
      \     },
      \     'UniteWithCursorWord',
      \     'UniteWithInput'
      \   ]
      \ }}

NeoBundleLazy 'hrsh7th/vim-versions', '', 'default', {
      \ 'autoload' : {
      \   'commands' : 'UniteVersions'
      \ }}

NeoBundleLazy 'Shougo/unite-outline', '', 'default', {
      \ 'autoload' : {
      \   'unite_sources' : 'outline',
      \ }}

NeoBundleLazy 'ujihisa/unite-font', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \   'unite_sources' : 'font',
      \ }}

NeoBundleLazy 'thinca/vim-unite-history', {
      \ 'autoload' : {
      \   'unite_sources' : [
      \     'history/command',
      \     'history/search'
      \   ]
      \ }}

NeoBundleLazy 'Shougo/unite-help', {
      \ 'autoload' : {
      \   'unite_sources' : 'help',
      \ }}

NeoBundleLazy 'tsukkee/unite-tag', {
      \ 'autoload' : {
      \   'unite_sources' : 'tag',
      \ }}

NeoBundleLazy 'ujihisa/unite-colorscheme', {
      \ 'autoload' : {
      \   'unite_sources' : 'colorscheme',
      \ }}

NeoBundleLazy 'ujihisa/unite-locate', {
      \ 'autoload' : {
      \   'unite_sources' : 'locate',
      \ }}

NeoBundleLazy 'pasela/unite-webcolorname', {
      \ 'autoload' : {
      \   'unite_sources' : 'webcolorname',
      \ }}

NeoBundleLazy 'osyo-manga/unite-filetype', {
      \ 'autoload' : {
      \   'unite_sources' : 'filetype',
      \ }}

NeoBundleLazy 'osyo-manga/unite-quickfix', {
      \ 'autoload' : {
      \   'unite_sources' : 'quickfix',
      \ }}

NeoBundleLazy 'soh335/unite-qflist', {
      \ 'autoload' : {
      \   'unite_sources' : 'qflist',
      \ }}

NeoBundle 'Shougo/unite-build', '', 'default'
NeoBundle 'Shougo/unite-ssh', '', 'default'
NeoBundle 'Shougo/unite-sudo', '', 'default'
"}}}

NeoBundleLazy 'Shougo/neocomplcache', '', 'default', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}

"NeoBundleLazy 'Shougo/neocomplcache-rsense', '', 'default', {
"      \ 'depends' : 'Shougo/neocomplcache',
"      \ 'autoload' : {
"      \   'filetypes' : 'ruby'
"      \ }}

NeoBundleLazy 'Shougo/neosnippet', '', 'default', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   'filetypes' : 'snippet',
      \   'unite_sources' : ['snippet', 'neosnippet/user', 'neosnippet/runtime'],
      \ }}

NeoBundleLazy 'Shougo/vimfiler', '', 'default', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'commands' : [
      \     { 'name' : 'VimFiler',
      \       'complete' : 'customlist,vimfiler#complete' },
      \     { 'name' : 'VimFilerExplorer',
      \       'complete' : 'customlist,vimfiler#complete' },
      \     { 'name' : 'Edit',
      \       'complete' : 'customlist,vimfiler#complete' },
      \     { 'name' : 'Write',
      \       'complete' : 'customlist,vimfiler#complete' },
      \     'Read',
      \     'Source'
      \   ],
      \   'mappings' : ['<Plug>(vimfiler_switch)'],
      \   'explorer' : 1,
      \ }}

NeoBundleLazy 'tyru/vim-altercmd', {
      \ 'autoload' : {
      \   'mappings' : ':'
      \ }}

NeoBundleLazy 'Shougo/vimshell', '', 'default', {
      \ 'autoload' : {
      \   'commands' : [
      \     {
      \       'name' : 'VimShell',
      \       'complete' : 'customlist,vimshell#complete'
      \     },
      \     'VimShellExecute',
      \     'VimShellInteractive',
      \     'VimShellTerminal',
      \     'VimShellPop'
      \   ],
      \   'mappings' : ['<Plug>(vimshell_switch)']
      \ }}

NeoBundleLazy 'ujihisa/vimshell-ssh', {
      \ 'autoload' : {
      \   'filetypes' : 'vimshell',
      \ }}

NeoBundleLazy 'yomi322/vim-gitcomplete', {
      \ 'autoload' : {
      \   'filetype' : 'vimshell'
      \ }}

NeoBundleLazy 'Shougo/vim-vcs', {
      \ 'depends' : 'thinca/vim-openbuf',
      \ 'autoload' : {
      \   'filetypes' : 'vimshell',
      \   'commands' : 'Vcs'
      \ }}

NeoBundleLazy 'anyakichi/vim-surround', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['n', '<Plug>Dsurround'],
      \     ['n', '<Plug>Csurround'],
      \     ['n', '<Plug>Ysurround'],
      \     ['x', '<Plug>Vsurround'],
      \     ['x', '<Plug>VSurround'],
      \   ]
      \ }}

" operator "{{{
NeoBundleLazy 'kana/vim-operator-user', {
      \ 'autoload' : {
      \   'functions' : [
      \     'operator#user#define',
      \     'operator#user#define_ex_command',
      \     'operator#user#visual_command_from_wise_name',
      \   ]
      \ }}

NeoBundleLazy 'kana/vim-operator-replace', {
      \ 'depends' : 'kana/vim-operator-user',
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>(operator-replace)']
      \   ]
      \ }}

NeoBundleLazy 'tyru/operator-html-escape.vim', {
      \ 'depends' : 'kana/vim-operator-user',
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>(operator-html-escape)']
      \   ]
      \ }}
"}}}

NeoBundleLazy 'kana/vim-textobj-user', {
      \ 'autoload' : {
      \   'functions' : [
      \     'textobj#user#define',
      \     'textobj#user#move',
      \     'textobj#user#plugin',
      \     'textobj#user#select',
      \     'textobj#user#select_pair',
      \   ]
      \ }}

NeoBundleLazy 'kana/vim-smartchr', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}

NeoBundleLazy 'sjl/gundo.vim', {
      \ 'autoload' : {
      \   'commands' : 'GundoToggle'
      \ }}

NeoBundleLazy 'thinca/vim-fontzoom', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \   'mappings' : [
      \     ['n', '<Plug>(fontzoom-larger)'],
      \     ['n', '<Plug>(fontzoom-smaller)']
      \   ]
      \ }}

NeoBundleLazy 'thinca/vim-qfreplace', {
      \ 'autoload' : {
      \   'filetypes' : ['unite', 'quickfix'],
      \ }}

NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nxo', '<Plug>(quickrun)']
      \   ],
      \ }}

NeoBundleLazy 'thinca/vim-visualstar', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(visualstar-*)',
      \     '<Plug>(visualstar-#)',
      \     '<Plug>(visualstar-g*)',
      \     '<Plug>(visualstar-g#)',
      \   ],
      \ }}

NeoBundle 'h1mesuke/vim-alignta', {
      \ 'autoload' : {
      \   'commands' : [ 'Align', 'Alignta' ]
      \ }}

NeoBundleLazy 'AndrewRadev/switch.vim', {
      \ 'autoload' : {
      \   'commands' : 'Switch',
      \ }}

NeoBundleLazy 'teramako/jscomplete-vim', {
      \ 'autoload' : {
      \   'filetypes' : ['javascript']
      \ }}

NeoBundleLazy 'jelera/vim-javascript-syntax', {
      \ 'autoload' : {
      \   'filetypes' : ['javascript']
      \ }}

NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {
      \ 'autoload' : {
      \   'filetypes' : ['javascript']
      \ }}

NeoBundleLazy 'hail2u/vim-css3-syntax', {
      \ 'autoload' : {
      \   'filetypes' : 'css',
      \ }}

NeoBundleLazy 'Shougo/echodoc', '', 'default', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}

NeoBundleLazy 'bkad/CamelCaseMotion', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>CamelCaseMotion_w',
      \     '<Plug>CamelCaseMotion_b'
      \   ],
      \ }}

NeoBundleLazy 'kana/vim-niceblock', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['v', '<Plug>(niceblock-I)'],
      \     ['v', '<Plug>(niceblock-A)']
      \   ]
      \ }}

NeoBundleLazy 'kana/vim-smarttill', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(smarttill-t)',
      \     '<Plug>(smarttill-T)'
      \   ]
      \ }}

NeoBundleLazy 'kana/vim-smartword', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(smartword-w)',
      \     '<Plug>(smartword-b)',
      \     '<Plug>(smartword-ge)'
      \   ]
      \ }}

NeoBundleLazy 'kana/vim-tabpagecd'

NeoBundleLazy 'repeat.vim', {
      \ 'autoload' : {
      \   'mappings' : '.',
      \ }}

NeoBundleLazy 'rhysd/accelerated-jk', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(accelerated_jk_gj)',
      \     '<Plug>(accelerated_jk_gk)'
      \   ],
      \ }}

NeoBundleLazy 'rhysd/clever-f.vim', {
      \ 'autoload' : {
      \   'mappings' : 'f',
      \ }}

NeoBundleLazy 'tyru/caw.vim', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(caw:prefix)',
      \     '<Plug>(caw:i:toggle)'
      \   ]
      \ }}

NeoBundleLazy 'tyru/restart.vim', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \   'commands' : 'Restart'
      \ }}

NeoBundleLazy 'vim-jp/autofmt', {
      \ 'autoload' : {
      \   'mappings' : [['x', 'gq']],
      \ }}

NeoBundleLazy 'deton/jasegment.vim', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['n', '<Plug>JaSegmentMoveNE'],
      \     ['n', '<Plug>JaSegmentMoveNW'],
      \     ['n', '<Plug>JaSegmentMoveNB'],
      \     ['o', '<Plug>JaSegmentMoveOE'],
      \     ['o', '<Plug>JaSegmentMoveOW'],
      \     ['o', '<Plug>JaSegmentMoveOB'],
      \     ['x', '<Plug>JaSegmentMoveVE'],
      \     ['x', '<Plug>JaSegmentMoveVW'],
      \     ['x', '<Plug>JaSegmentMoveVB'],
      \   ],
      \ }}

NeoBundleLazy 'vim-ruby/vim-ruby', {
      \ 'autoload' : {
      \   'mappings' : '<Plug>(ref-keyword)',
      \   'filetypes' : 'ruby'
      \ }}

NeoBundleLazy 'thinca/vim-ref', {
      \ 'autoload' : {
      \   'commands' : 'Ref'
      \ }}

NeoBundleLazy 'HybridText', {
      \ 'autoload' : {
      \   'filetypes' : 'hybrid',
      \ }}

NeoBundleLazy 'autodate.vim', {
      \ 'autoload' : {
      \   'filetypes' : [
      \     'text',
      \     'hybrid',
      \   ]
      \ }}

NeoBundleLazy 'Shougo/vinarise', '', 'default', {
      \ 'autoload' : {
      \   'commands' : 'Vinarise',
      \ }}

NeoBundleLazy 'tyru/open-browser.vim', {
      \ 'autoload' : {
      \   'mappings' : '<Plug>(open-browser-wwwsearch)',
      \ }}

NeoBundleLazy 'yuratomo/w3m.vim', {
      \ 'autoload' : {
      \   'commands' : 'W3m',
      \ }}

NeoBundleLazy 'Shougo/vesting', '', 'default', {
      \ 'autoload' : {
      \   'commands' : 'Unite',
      \ }}

NeoBundleLazy 'vim-jp/vital.vim', '', 'default', {
      \ 'autoload' : {
      \     'commands' : ['Vitalize'],
      \ }}

NeoBundleLazy 'Shougo/junkfile.vim', '', 'default', {
      \ 'autoload' : {
      \   'commands' : 'JunkfileOpen',
      \   'unite_sources' : ['junkfile', 'junkfile/new'],
      \ }}

NeoBundleLazy 'itchyny/thumbnail.vim', {
      \ 'autoload' : {
      \   'commands' : 'Thumbnail'
      \ }}

NeoBundleLazy 'godlygeek/csapprox', {
      \   'terminal' : 1
      \ }

NeoBundleLazy 'thinca/vim-guicolorscheme', {
      \   'terminal' : 1
      \ }

NeoBundle 'tyru/winmove.vim', {
      \   'gui' : 1
      \ }

NeoBundle 'Shougo/neobundle-vim-scripts', '', 'default'
NeoBundle 'Shougo/foldCC'
NeoBundle 'kano4/errormarker.vim'
NeoBundle 'matchit.zip'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-submode'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'xoria256.vim'

NeoBundleLazy 'mattn/webapi-vim'
NeoBundleLazy 'kien/ctrlp.vim'
NeoBundleLazy 'mattn/wwwrenderer-vim'
NeoBundleLazy 'rbtnn/hexript.vim'
"}}}

" Disable GetLatestVimPlugin.vim
let g:loaded_getscriptPlugin = 1

" Disable netrw.vim
let g:loaded_netrwPlugin = 1

filetype plugin indent on

" Installation check.
NeoBundleCheck

"}}}

" Encoding: "{{{
" The automatic recognition of the character code.

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
set encoding=utf-8

" Setting of terminal encoding. "{{{
if !has('gui_running')
  if &term == 'win32' || &term == 'win64'
    " Setting when use the non-GUI Japanese console.

    " Garbled unless set this.
    set termencoding=cp932
    " Japanese input changes itself unless set this. Be careful because the
    " automatic recognition of the character code is not possible!
    set encoding=japan
  else
    if $ENV_ACCESS ==# 'linux'
      set termencoding=euc-jp
    elseif $ENV_ACCESS ==# 'colinux'
      set termencoding=utf-8
    else  " fallback
      set termencoding=  " same as 'encoding'
    endif
  endif
elseif s:is_windows
  " For system.
  set termencoding=cp932
endif
"}}}

" The automatic recognition of the character code. "{{{
if !exists('did_encoding_settings') && has('iconv')

  " Does iconv support JIS X 0213?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  else
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
  endif

  " Build encodings.
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    " UTF-8環境向け
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    " EUC-JP環境向け
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else " CP932環境向け
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif

  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis

  let did_encoding_settings = 1
endif
"}}}

if has('kaoriya')
  " For Kaoriya only.
  set fileencodings=guess
endif

" When do not include Japanese, use encoding for fileencoding.
function! s:ReCheck_FENC() "{{{
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding=&encoding
  endif
endfunction
"}}}

autocmd MyAutoCmd BufReadPost * call s:ReCheck_FENC()

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac
" A fullwidth character is displayed in vim properly.
set ambiwidth=double

" Command group opening with a specific character code again. "{{{
" In particular effective when I am garbled in a terminal.
command! -bang -bar -complete=file -nargs=? Euc
      \ edit<bang> ++enc=euc-jp <args>
command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>
command! -bang -bar -complete=file -nargs=? Utf16
      \ edit<bang> ++enc=ucs-2le <args>
command! -bang -bar -complete=file -nargs=? Utf16be
      \ edit<bang> ++enc=ucs-2 <args>
command! -bang -bar -complete=file -nargs=? Iso2022jp
      \ edit<bang> ++enc=iso-2022-jp <args>

" Aliases.
command! -bang -bar -complete=file -nargs=? Sjis Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>
command! -bang -bar -complete=file -nargs=? Jis Iso2022jp<bang> <args>
"}}}

" Tried to make a file note version. "{{{
" Don't save it because dangerous.
command! WEuc setlocal fenc=euc-jp
command! WUtf8 setlocal fenc=utf-8
command! WCp932 setlocal fenc=cp932
command! WUtf16 setlocal fenc=ucs-2le
command! WUtf16be setlocal fenc=ucs-2
command! WIso2022jp setlocal fenc=iso-2022-jp
" Aliases.
command! WSjis WCp932
command! WUnicode WUtf16
command! WJis WIso2022jp
"}}}

" Appoint a line feed. "{{{
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos  <args> | edit <args>
command! -bang -complete=file -nargs=? WMac
      \ write<bang> ++fileformat=mac  <args> | edit <args>
"}}}

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif
"}}}

" Search: "{{{

" * 等での検索時 - で切らない
set iskeyword& iskeyword+=-

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

"}}}

" Edit: "{{{

" タブをスペースにする
set smarttab
set expandtab

" 保存時に行末のスペースを除去する
function! s:rtrim()
  let cursor = getpos(".")
  %s/\S\zs\s\+$//e
  call setpos(".", cursor)
endfunction
autocmd BufWritePre * call <SID>rtrim()

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

" 自動で折り返ししない
autocmd MyAutoCmd FileType *
      \ if &l:textwidth != 70 && &filetype !=# 'help' |
      \    setlocal textwidth=0 |
      \ endif

" BackSpaceの挙動を設定
set backspace=indent,eol,start

" 対応する括弧の表示
set showmatch
set cpoptions& cpoptions-=m
set matchtime=3
set matchpairs& matchpairs+=<:>

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
set foldcolumn=3
set fillchars=vert:\|
set commentstring=%s

if exists('*FoldCCtext')
  set foldtext=FoldCCtext()
  autocmd MyAutoCmd FileType *
        \   if &filetype !=# 'help'
        \ |   setlocal foldtext=FoldCCtext()
        \ | endif
endif

" :grep で使われるプログラムの指定
set grepprg=grep\ -nH

" ファイル名やパス名に使われる文字の指定
set isfname& isfname-==

" .vimrcや.gvimrcが変更された際、自動的に変更を反映する
if !has('gui_running') && !s:is_windows
  autocmd MyAutoCmd BufWritePost .vimrc nested source $MYVIMRC |
      \ call s:set_syntax_of_user_defined_commands() |
      \ echo "source $MYVIMRC"
else
  autocmd MyAutoCmd BufWritePost .vimrc source $MYVIMRC |
      \ call s:set_syntax_of_user_defined_commands() |
      \ if has('gui_running') | source $MYGVIMRC | echo "source $MYVIMRC"
  autocmd MyAutoCmd BufWritePost .gvimrc
      \ if has('gui_running') | source $MYGVIMRC | echo "source $MYGVIMRC"
endif

" タイムアウト設定
set timeout timeoutlen=3000 ttimeoutlen=100

" スワップファイルがディスクに書き込まれるまでの時間を設定
set updatetime=1000

" スワップファイル用ディレクトリの指定
set directory& directory-=.

if v:version >= 703
  " vimを終了してもundo履歴を復元する
  set undofile
  let &undodir=&directory
endif

" tagの設定
set tags& tags-=tags tags+=./tags;
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
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif

"}}}

" View: "{{{

" 特殊文字を可視化
set list
if s:is_windows
  set listchars=tab:>-,trail:-,extends:>,precedes:<
else
  set listchars=tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%
endif

" ウィンドウの幅より長い行を折り返さない
set nowrap

" 折り返し時の行頭・行末間移動を可能に
set whichwrap& whichwrap+=h,l,<,>,[,],b,s,~

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

" タイトルに表示する文字列
let &titlestring = "%{(&filetype ==# 'lingr-messages' && lingr#unread_count() > 0 )?"
         \ . " '('.lingr#unread_count().')' : ''}%{expand('%:p:.')}%(%m%r%w%)"
         \ . " \ %<\(%{SnipMid(getcwd(),80-len(expand('%:p:.')),'...')}\) - Vim"

" タブページ行の表示 "{{{
function! s:my_tabline()
  let s = ''

  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears

    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '

    " Use gettabvar().
    let title =
          \ !exists('*gettabvar') ?
          \      fnamemodify(bufname(bufnr), ':t') :
          \ gettabvar(i, 'title') != '' ?
          \      gettabvar(i, 'title') :
          \      fnamemodify(gettabvar(i, 'cwd'), ':t')

    let title = '[' . title . ']'

    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor

  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2
"}}}

" ステータス行に表示する文字列の設定
let &statusline="%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
      \ . ".(winnr('#')==winnr()?'#':'').']':''}\ %{expand('%:p:.')}"
      \ . "\ %=%m%y%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}"
      \ . "%{printf(' %5d/%d',line('.'),line('$'))}"

" 折り返し表示の設定
set linebreak
set showbreak=>\
set breakat=\ \	;:,!?

" Do not display greetings message at the time of Vim start.
set shortmess=aTI

" バックアップは自分でする
set nowritebackup
set nobackup
set backupdir-=.

" ベルを無効にする
set t_vb=
set novisualbell

" コマンドライン補完
set nowildmenu
set wildmode=list:longest,full

" コマンドと以前に使った検索パターン履歴の保存個数
set history=200

" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag

" Can supplement a tag in a command-line.
set wildoptions=tagfile

" US英語の時スペルチェックを有効にする
set spelllang=en_us

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

" 最後の行が収まりきらない時 @ と表示しない
set display=lastline

" コメントの自動挿入をしない
autocmd MyAutoCmd FileType *
      \ setlocal formatoptions-=ro | setlocal formatoptions+=mM

" 指定した列を強調表示
if v:version >= 703
  " For conceal.
  set conceallevel=2 concealcursor=iv

  set colorcolumn=85
endif

" View setting.
set viewdir=~/.vim/view viewoptions-=options viewoptions+=slash,unix

" Vim外にいるときはVimを透けさせる
augroup MyAutoCmd
  if has('mac')
    autocmd FocusGained * set transparency=10
    autocmd FocusLost * set transparency=50
  endif
augroup END

"}}}

" Syntax: "{{{

" 構文ハイライト
syntax enable

" smart indentを有効にする
set autoindent smartindent

augroup MyAutoCmd
  " Enable gauche syntax.
  autocmd FileType scheme nested let b:is_gauche=1 | setlocal lispwords=define |
        \let b:current_syntax='' | syntax enable

  " Auto reload VimScript.
  autocmd BufWritePost,FileWritePost *.vim if &autoread
        \ | source <afile> | echo 'source ' . bufname('%') | endif

  " Manage long Rakefile easily
  autocmd BufNewfile,BufRead Rakefile set foldmethod=syntax foldnestmax=1

  autocmd FileType help,qf,quickrun,qfreplace,ref
        \ nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>

  autocmd FileType * if (&readonly || !&modifiable) && !hasmapto('q', 'n')
        \ | nnoremap <buffer><silent> q :<C-u>call <sid>smart_close()<CR>| endif

  autocmd FileType qfreplace setlocal nofoldenable

  autocmd FileType ref nnoremap <buffer> <TAB> <C-w>w

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Update filetype.
  autocmd BufWritePost *
  \ if &l:filetype ==# '' || exists('b:ftdetect')
  \ |   unlet! b:ftdetect
  \ |   filetype detect
  \ | endif

  autocmd BufEnter,BufNewFile * if bufname('%') != '' && &filetype == ''
        \ | setlocal ft=hybrid | endif

augroup END

" PHP
let g:php_folding = 0

" Python
let g:python_highlight_all = 1

" XML
let g:xml_syntax_folding = 1

" Vim
let g:vimsyntax_noerror = 1

" Bash
let g:is_bash = 1

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_highlight_debug = 1
let g:java_allow_cpp_keywords = 1
let g:java_space_errors = 1
let g:java_highlight_functions = 1

" JavaScript
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Syntax highlight for user commands.
augroup syntax-highlight-extends
  autocmd!
  autocmd Syntax vim
        \ call s:set_syntax_of_user_defined_commands()
augroup END

function! s:set_syntax_of_user_defined_commands()
  redir => _
  silent! command
  redir END

  let command_names = join(map(split(_, '\n')[1:],
        \ "matchstr(v:val, '[!\"b]*\\s\\+\\zs\\u\\w*\\ze')"))

  if command_names == '' | return | endif

  execute 'syntax keyword vimCommand ' . command_names
endfunction

"}}}

" Key-mappings: "{{{

" Use <C-Space>.
map  <C-Space> <C-@>
cmap <C-Space> <C-@>

" Move to top/center/bottom.
noremap <expr> zz (winline() == (winheight(0)+1)/ 2) ?
      \ 'zt' : (winline() == 1)? 'zb' : 'zz'

" Normal mode keymappings: "{{{

" Smart <C-f>, <C-b>.
nnoremap <silent> <C-f> <C-f>
nnoremap <silent> <C-b> <C-b>

" Disable ZZ.
nnoremap ZZ <Nop>

" Redraw.
nnoremap <silent> <C-l> :<C-u>redraw!<CR>

" Clear highlight.
nnoremap <ESC><ESC> :nohlsearch<CR>

"}}}

" Visual mode keymappings: "{{{

" <TAB>: indent.
xnoremap <TAB> >

" <S-TAB>: unindent.
xnoremap <S-TAB> <

" Indent
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

" Select until end of current line in visual mode.
xnoremap v $h
"}}}

" Insert mode keymappings: "{{{

" <C-t>: insert tab.
inoremap <C-t> <C-v><TAB>

" <C-d>: delete char.
inoremap <C-d> <Del>

" <C-a>: move to head.
inoremap <silent><C-a> <C-o>^

" Enable undo <C-w> and <C-u>.
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>

"}}}

" Command-line mode keymappings:"{{{
" <C-a>, A: move to head.
cnoremap <C-a> <Home>
" <C-b>: previous char.
cnoremap <C-b> <Left>
" <C-d>: delete char.
cnoremap <C-d> <Del>
" <C-e>, E: move to end.
cnoremap <C-e> <End>
" <C-f>: next char.
cnoremap <C-f> <Right>
" <C-n>: next history.
cnoremap <C-n> <Down>
" <C-p>: previous history.
cnoremap <C-p> <Up>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>
" <C-y>: paste.
cnoremap <C-y> <C-r>*

" Auto escape / and ? in search command.
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
"}}}

" Command line buffer."{{{
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

nmap ;; <SID>(command-line-enter)
xmap ;; <SID>(command-line-enter)

autocmd MyAutoCmd CmdwinEnter * call s:init_cmdwin()
autocmd MyAutoCmd CmdwinLeave * let g:neocomplcache_enable_auto_select = 1

function! s:init_cmdwin()
  NeoBundleSource vim-altercmd

  let g:neocomplcache_enable_auto_select = 0
  let b:neocomplcache_sources_list = ['vim_complete']

  nnoremap <buffer><silent> q :<C-u>quit<CR>
  nnoremap <buffer><silent> <TAB> :<C-u>quit<CR>
  inoremap <buffer><expr><CR> neocomplcache#close_popup()."\<CR>"
  inoremap <buffer><expr><C-h> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplcache#cancel_popup()."\<C-h>"
  inoremap <buffer><expr><BS> col('.') == 1 ?
        \ "\<ESC>:quit\<CR>" : neocomplcache#cancel_popup()."\<C-h>"

  " Completion.
  inoremap <buffer><expr><TAB> pumvisible() ?
        \ "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>\<C-p>"

  startinsert!
endfunction
"}}}

" [Space]: Other useful commands "{{{

" Toggle relativenumber.
nnoremap <silent> [Space].
      \ :<C-u>call ToggleOption('relativenumber')<CR>

" Toggle paste.
nnoremap <silent> [Space]p
      \ :<C-u>call ToggleOption('paste')<CR>:set mouse=<CR>

" Toggle wrap
nnoremap [Space]w
      \ :<C-u>call ToggleOption('wrap')<CR>

" Toggle highlight.
nnoremap <silent> [Space]/
      \ :<C-u>call ToggleOption('hlsearch')<CR>

" Toggle number.
nnoremap <silent> [Space]n
      \ :<C-u>call ToggleOption('number')<CR>

" Toggle cursorline.
nnoremap <silent> [Space]cl
      \ :<C-u>call ToggleOption('cursorline')<CR>

" Set autoread.
nnoremap [Space]ar
      \ :<C-u>setlocal autoread<CR>

" Output encoding information.
nnoremap <silent> [Space]en
      \ :<C-u>setlocal encoding? termencoding? fenc? fencs?<CR>

" Set spell check.
nnoremap [Space]sp
      \ :<C-u>call ToggleOption('spell')<CR>

" Echo syntax name.
nnoremap [Space]sy
      \ :<C-u>echo synIDattr(synID(line('.'), col('.'), 1), "name")<CR>

" Easily edit .vimrc and .gvimrc "{{{
nnoremap <silent> [Space]ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [Space]eg :<C-u>edit $MYGVIMRC<CR>

" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> [Space]rv :<C-u>source $MYVIMRC \|
      \ if has('gui_running') \|
      \   source $MYGVIMRC \|
      \ endif \| echo "source $MYVIMRC"<CR>
nnoremap <silent> [Space]rg
      \ :<C-u>source $MYGVIMRC \|
      \ echo "source $MYGVIMRC"<CR>
"}}}

" Useful save mappings.
nnoremap <Leader><Leader> :<C-u>update<CR>

" Change current directory.
nnoremap <silent> [Space]cd :<C-u>call <SID>cd_buffer_dir()<CR>
function! s:cd_buffer_dir() "{{{
  let filetype = getbufvar(bufnr('%'), '&filetype')
  if filetype ==# 'vimfiler'
    let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
  elseif filetype ==# 'vimshell'
    let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
  else
    let dir = isdirectory(bufname('%')) ?
          \ bufname('%') : fnamemodify(bufname('%'), ':p:h')
  endif

  cd `=dir`
endfunction
"}}}

" Delete windows ^M codes.
nnoremap <silent> [Space]<C-m> mmHmt:<C-u>%s/\r$//ge<CR>'tzt'm

" Delete spaces before newline.
nnoremap <silent> [Space]ss mmHmt:<C-u>%s/<Space>$//ge<CR>`tzt`m

" Easily syntax change.
nnoremap <silent> [Space]ft :<C-u>Unite -start-insert filetype<CR>

" Exchange gj and gk to j and k. "{{{
command! -nargs=? -bar -bang ToggleGJK call s:ToggleGJK()
nnoremap <silent> [Space]gj :<C-u>ToggleGJK<CR>
xnoremap <silent> [Space]gj :<C-u>ToggleGJK<CR>
function! s:ToggleGJK()
  if exists('b:enable_mapping_gjk') && b:enable_mapping_gjk
    let b:enable_mapping_gjk = 0
    noremap <buffer> j j
    noremap <buffer> k k
    noremap <buffer> gj gj
    noremap <buffer> gk gk

    xnoremap <buffer> j j
    xnoremap <buffer> k k
    xnoremap <buffer> gj gj
    xnoremap <buffer> gk gk
  else
    let b:enable_mapping_gjk = 1
    noremap <buffer> j gj
    noremap <buffer> k gk
    noremap <buffer> gj j
    noremap <buffer> gk k

    xnoremap <buffer> j gj
    xnoremap <buffer> k gk
    xnoremap <buffer> gj j
    xnoremap <buffer> gk k
  endif
endfunction
"}}}

" Change tab width. "{{{
nnoremap <silent> [Space]t2 :<C-u>setl shiftwidth=2 softtabstop=2<CR>
nnoremap <silent> [Space]t4 :<C-u>setl shiftwidth=4 softtabstop=4<CR>
nnoremap <silent> [Space]t8 :<C-u>setl shiftwidth=8 softtabstop=8<CR>
"}}}

"}}}

" s: Windows and buffers(High priority) "{{{
nnoremap <silent> [Window]p :<C-u>call <SID>split_nicely()<CR>
nnoremap <silent> [Window]v :<C-u>vsplit<CR>
nnoremap <silent> [Window]c :<C-u>call <sid>smart_close()<CR>
nnoremap <silent> - :<C-u>call <sid>smart_close()<CR>
nnoremap <silent> [Window]o :<C-u>only<CR>
nnoremap <silent> [Window]b :<C-u>Thumbnail<CR>

" Syntax check.
nnoremap <silent> [Window]y
      \ :<C-u>echo map(synstack(line('.'), col('.')),
      \     'synIDattr(v:val, "name")')<CR>

function! s:smart_close()
  if winnr('$') != 1
    close
  endif
endfunction

" If window isn't splited, split buffer.
nnoremap <silent> [Window]<Space> :<C-u>call <SID>ToggleSplit()<CR>
function! s:ToggleSplit()
  let prev_name = winnr()
  silent! wincmd w
  if prev_name == winnr()
    SplitNicely
  else
    call s:smart_close()
  endif
endfunction

" Split nicely."{{{
command! SplitNicely call s:split_nicely()
function! s:split_nicely()
  " Split nicely.
  if winwidth(0) > 2 * &winwidth
    vsplit
  else
    split
  endif
  wincmd p
endfunction
"}}}

" Delete current buffer."{{{
nnoremap <silent> [Window]d :<C-u>call <SID>CustomBufferDelete(0)<CR>
" Force delete current buffer.
nnoremap <silent> [Window]D :<C-u>call <SID>CustomBufferDelete(1)<CR>
function! s:CustomBufferDelete(is_force)
  let current = bufnr('%')

  call unite#util#alternate_buffer()

  if a:is_force
    silent! execute 'bdelete! ' . current
  else
    silent! execute 'bdelete ' . current
  endif
endfunction
"}}}

"}}}

" e: Change basic commands "{{{

" Indent paste.
nnoremap <silent> [Alt]p o<Esc>pm``[=`]``^
xnoremap <silent> [Alt]p o<Esc>pm``[=`]``^
nnoremap <silent> [Alt]P O<Esc>Pm``[=`]``^
xnoremap <silent> [Alt]P O<Esc>Pm``[=`]``^

" Insert blank line.
nnoremap <silent> [Alt]o o<Space><BS><ESC>
nnoremap <silent> [Alt]O O<Space><BS><ESC>

" Yank to end line.
nnoremap [Alt]y y$
nnoremap Y y$
nnoremap x "_x

" Useless commands
nnoremap [Alt]; ;
nnoremap [Alt], ,

"}}}

" q: Quickfix  "{{{

" Disable Ex-mode.
nnoremap Q  q

" Toggle quickfix window. "{{{
nnoremap <silent> [Quickfix]<Space>
      \ :<C-u>call <SID>toggle_quickfix_window()<CR>
function! s:toggle_quickfix_window()
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    copen
    setlocal nowrap
    setlocal whichwrap=b,s
  endif
endfunction
"}}}

"}}}

" Jump mark can restore column."{{{
nnoremap \ `
" Useless command.
nnoremap M m
"}}}

" Smart }."{{{
nnoremap <silent> } :<C-u>call ForwardParagraph()<CR>
onoremap <silent> } :<C-u>call ForwardParagraph()<CR>
xnoremap <silent> } <Esc>:<C-u>call ForwardParagraph()<CR>mzgv`z
function! ForwardParagraph()
  let cnt = v:count ? v:count : 1
  let i = 0
  while i < cnt
    if !search('^\s*\n.*\S','W')
      normal! G$
      return
    endif
    let i = i + 1
  endwhile
endfunction
"}}}

" Smart home and smart end."{{{
nnoremap <silent> gh  :<C-u>call SmartHome('n')<CR>
nnoremap <silent> gl  :<C-u>call SmartEnd('n')<CR>
xnoremap <silent> gh  <ESC>:<C-u>call SmartHome('v')<CR>
xnoremap <silent> gl  <ESC>:<C-u>call SmartEnd('v')<CR>

" Smart home function "{{{
function! SmartHome(mode)
  let curcol = col('.')

  if &wrap
    normal! g^
  else
    normal! ^
  endif
  if col('.') == curcol
    if &wrap
      normal! g0
    else
      normal! 0
    endif
  endif

  if a:mode == "v"
    normal! msgv`s
  endif

  return ""
endfunction
"}}}

" Smart end function"{{{
function! SmartEnd(mode)
  let curcol = col('.')
  let lastcol = a:mode ==# 'i' ? col('$') : col('$') - 1

  " Gravitate towards ending for wrapped lines
  if curcol < lastcol - 1
    call cursor(0, curcol + 1)
  endif

  if curcol < lastcol
    if &wrap
      normal! g$
    else
      normal! $
    endif
  else
    normal! g_
  endif

  " Correct edit mode cursor position, put after current character
  if a:mode == "i"
    call cursor(0, col(".") + 1)
  endif

  if a:mode == "v"
    normal! msgv`s
  endif

  return ""
endfunction
"}}}
"}}}

" Jump to a line and the line of before and after of the same indent."{{{
" Useful for Python.
nnoremap <silent> g{ :<C-u>call search('^' .
      \ matchstr(getline(line('.') + 1), '\(\s*\)') .'\S', 'b')<CR>^
nnoremap <silent> g} :<C-u>call search('^' .
      \ matchstr(getline(line('.')), '\(\s*\)') .'\S')<CR>^
"}}}

" Paste next line. "{{{
nnoremap <silent> gp o<ESC>p^
nnoremap <silent> gP O<ESC>P^
xnoremap <silent> gp o<ESC>p^
xnoremap <silent> gP O<ESC>P^
"}}}

" Folding."{{{

" If press l on fold, fold open.
nnoremap <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'

" If press l on fold, range fold open.
xnoremap <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

noremap [Space]j zj
noremap [Space]k zk
noremap [Space]h zc
noremap [Space]l zo
noremap [Space]a za
noremap [Space]m zM
noremap [Space]i zMzv
noremap [Space]rr zR
noremap [Space]f zf
noremap [Space]d zd
noremap [Space]u :<C-u>Unite outline:foldings<CR>
noremap [Space]gg :<C-u>echo FoldCCnavi()<CR>
"}}}

" a>, i], etc... "{{{
" <angle>
onoremap aa a>
xnoremap aa a>
onoremap ia i>
xnoremap ia i>

" [rectangle]
onoremap ar a]
xnoremap ar a]
onoremap ir i]
xnoremap ir i]

" 'quote'
onoremap aq a'
xnoremap aq a'
onoremap iq i'
xnoremap iq i'

" "double quote"
onoremap ad a"
xnoremap ad a"
onoremap id i"
xnoremap id i"
"}}}

" Improved increment. "{{{
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment) :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement) :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call s:add_numbers((<line2>-<line1>+1) * eval(<args>))
function! s:add_numbers(num)
  let prev_line = getline('.')[: col('.')-1]
  let next_line = getline('.')[col('.') :]
  let prev_num = matchstr(prev_line, '\d\+$')
  if prev_num != ''
    let next_num = matchstr(next_line, '^\d\+')
    let new_line = prev_line[: -len(prev_num)-1] .
          \ printf('%0'.len(prev_num . next_num).'d',
          \    max([0, prev_num . next_num + a:num])) . next_line[len(next_num):]
  else
    let new_line = prev_line . substitute(next_line, '\d\+',
          \ "\\=printf('%0'.len(submatch(0)).'d',
          \         max([0, submatch(0) + a:num]))", '')
  endif

  if getline('.') !=# new_line
    call setline('.', new_line)
  endif
endfunction
"}}}

"}}}

" Plugin: "{{{

" unite.vim"{{{
nnoremap <expr><silent> ;b  <SID>unite_build()
function! s:unite_build()
  return ":\<C-u>Unite -buffer-name=build". tabpagenr() ." -no-quit build\<CR>"
endfunction

nnoremap <silent> ;g :<C-u>Unite grep -buffer-name=search -auto-preview -no-quit -resume<CR>
nnoremap <silent> ;n :<C-u>UniteResume search -no-start-insert<CR>
nnoremap <silent> ;o :<C-u>Unite outline -start-insert -resume<CR>
nnoremap <silent> ;r :<C-u>Unite -buffer-name=register register history/yank<CR>
nnoremap <silent> ;s :<C-u>Unite source -start-insert<CR>
nnoremap <silent> ;t :<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include<CR>
xnoremap <silent> ;r d:<C-u>Unite -buffer-name=register register history/yank<CR>
nnoremap <silent> ;w :<C-u>UniteWithCursorWord -buffer-name=register
      \ buffer file_mru bookmark file<CR>

nnoremap <silent> <C-k> :<C-u>Unite change jump<CR>

nnoremap <silent> [Window]t :<C-u>Unite tab<CR>
nnoremap <silent> [Window]w :<C-u>Unite window<CR>

if s:is_windows
  nnoremap <silent> [Window]s
        \ :<C-u>Unite -buffer-name=files -no-split -multi-line
        \ jump_point file_point buffer_tab
        \ file_rec:! file file/new file_mru<CR>
else
  nnoremap <silent> [Window]s
        \ :<C-u>Unite -buffer-name=files -no-split -multi-line
        \ jump_point file_point buffer_tab
        \ file_rec/async:! file file/new file_mru<CR>
endif

nnoremap <silent> [Space]b :<C-u>UniteBookmarkAdd<CR>

" t: tags-and-searches "{{{
nnoremap <silent><expr> [Tag]t &filetype == 'help' ? "\<C-]>" :
      \ ":\<C-u>UniteWithCursorWord -buffer-name=tag tag tag/include\<CR>"

nnoremap <silent> [Tag]n :<C-u>tag<CR>

nnoremap <silent><expr> [Tag]p &filetype == 'help' ?
      \ ":\<C-u>pop\<CR>" : ":\<C-u>Unite jump\<CR>"
"}}}

nnoremap <silent> <C-h> :<C-u>Unite -buffer-name=help help<CR>
nnoremap <silent> g<C-h> :<C-u>UniteWithCursorWord help<CR>

nnoremap <expr><silent> ;/ <SID>smart_search_expr(
      \ ":\<C-u>Unite -buffer-name=search -no-split -start-insert line/fast\<CR>",
      \ ":\<C-u>Unite -buffer-name=search -auto-highlight -start-insert line\<CR>")
nnoremap <silent> ;?
      \ :<C-u>Unite -buffer-name=search -auto-highlight -start-insert line:backward<CR>
nnoremap <silent><expr> ;* <SID>smart_search_expr(
      \ ":\<C-u>UniteWithCursorWord -no-split -buffer-name=search line/fast\<CR>",
      \ ":\<C-u>UniteWithCursorWord -auto-highlight -buffer-name=search line\<CR>")
cnoremap <expr><silent><C-g> (getcmdtype() == '/') ?
      \ "\<ESC>:Unite -buffer-name=search -no-split line -input=".getcmdline()."\<CR>" : "\<C-g>"

function! s:smart_search_expr(expr1, expr2)
  return line('$') > 5000 ? a:expr1 : a:expr2
endfunction

let g:unite_source_history_yank_enable = 1

let g:unite_source_alias_aliases = {}
let g:unite_source_alias_aliases.message = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }
let g:unite_source_alias_aliases.mes = {
      \ 'source' : 'output',
      \ 'args'   : 'message',
      \ }

let g:unite_source_menu_menus = {}

let g:unite_source_menu_menus.enc = {
      \   'description' : 'Open with a specific character code again.',
      \ }
let g:unite_source_menu_menus.enc.command_candidates = [
      \   ['utf8', 'Utf8'],
      \   ['iso2022jp', 'Iso2022jp'],
      \   ['cp932', 'Cp932'],
      \   ['euc', 'Euc'],
      \   ['utf16', 'Utf16'],
      \   ['utf16-be', 'Utf16be'],
      \   ['jis', 'Jis'],
      \   ['sjis', 'Sjis'],
      \   ['unicode', 'Unicode'],
      \ ]
nnoremap <silent> ;e :<C-u>Unite menu:enc<CR>

let g:unite_source_menu_menus.fenc = {
      \   'description' : 'Change file fenc option.',
      \ }
let g:unite_source_menu_menus.fenc.command_candidates = [
      \   ['utf8', 'WUtf8'],
      \   ['iso2022jp', 'WIso2022jp'],
      \   ['cp932', 'WCp932'],
      \   ['euc', 'WEuc'],
      \   ['utf16', 'WUtf16'],
      \   ['utf16-be', 'WUtf16be'],
      \   ['jis', 'WJis'],
      \   ['sjis', 'WSjis'],
      \   ['unicode', 'WUnicode'],
      \ ]
nnoremap <silent> ;f :<C-u>Unite menu:fenc<CR>

let g:unite_source_menu_menus.ff = {
      \   'description' : 'Change file format option.',
      \ }
let g:unite_source_menu_menus.ff.command_candidates = {
      \   'unix' : 'WUnix',
      \   'dos'  : 'WDos',
      \   'mac'  : 'WMac',
      \ }
nnoremap <silent> ;w :<C-u>Unite menu:ff<CR>

let g:unite_source_menu_menus.unite = {
      \   'description' : 'Start unite sources',
      \ }
let g:unite_source_menu_menus.unite.command_candidates = {
      \   'history'   : 'Unite history/command',
      \   'quickfix'  : 'Unite qflist -no-quit',
      \   'resume'    : 'Unite -buffer-name=resume resume',
      \   'directory' : 'Unite -buffer-name=files '.
      \         '-default-action=lcd directory_mru',
      \   'mapping'   : 'Unite mapping',
      \   'message'   : 'Unite output:message',
      \ }
nnoremap <silent> ;u :<C-u>Unite menu:unite -resume<CR>

let bundle = neobundle#get('unite.vim')
function! bundle.hooks.on_source(bundle)
  autocmd MyAutoCmd FileType unite call s:unite_my_settings()

  call unite#set_profile('action', 'context', {'start_insert' : 1})

  call unite#set_profile('source/grep', 'context', {'no_quit' : 1})

  call unite#filters#sorter_default#use(['sorter_rank'])

  function! s:unite_my_settings() "{{{
    call unite#set_substitute_pattern('files', '^\.v/',
          \ [expand('~/.vim/'), unite#util#substitute_path_separator($HOME)
          \ . '/.vim/bundle/*/'], 1000)
    call unite#set_substitute_pattern('files', '\.', '*.', 1000)
    call unite#custom_alias('file', 'h', 'left')
    call unite#custom_default_action('directory', 'narrow')
    call unite#set_substitute_pattern('file', '[^~.]\zs/', '*/*', 20)

    call unite#custom_default_action('versions/git/status', 'commit')

    let g:unite_quick_match_table = {
          \ 'a' : 1, 's' : 2, 'd' : 3, 'f' : 4, 'g' : 5,
          \ 'h' : 6, 'k' : 7, 'l' : 8, ';' : 9,
          \ 'q' : 10, 'w' : 11, 'e' : 12, 'r' : 13, 't' : 14,
          \ 'y' : 15, 'u' : 16, 'i' : 17, 'o' : 18, 'p' : 19,
          \ '1' : 20, '2' : 21, '3' : 22, '4' : 23, '5' : 24,
          \ '6' : 25, '7' : 26, '8' : 27, '9' : 28, '0' : 29,
          \}

    " Custom actions."{{{
    let my_tabopen = {
          \   'description' : 'my tabopen items',
          \   'is_selectable' : 1,
          \ }
    function! my_tabopen.func(candidates) "{{{
      call unite#take_action('tabopen', a:candidates)

      let dir = isdirectory(a:candidates[0].word) ?
            \ a:candidates[0].word : fnamemodify(a:candidates[0].word, ':p:h')
      execute g:unite_kind_openable_lcd_command '`=dir`'
    endfunction
    "}}}
    call unite#custom_action('file,buffer', 'tabopen', my_tabopen)
    unlet my_tabopen
    "}}}

    " Overwrite settings.
    imap <buffer> <BS> <Plug>(unite_delete_backward_path)
    imap <buffer> jj   <Plug>(unite_insert_leave)
    imap <buffer><expr> j unite#smart_map('j', '')
    imap <buffer> <TAB> <Plug>(unite_select_next_line)
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    imap <buffer> '     <Plug>(unite_quick_match_default_action)
    nmap <buffer> '     <Plug>(unite_quick_match_default_action)
    imap <buffer><expr> x
          \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
    nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
    nmap <buffer> cd    <Plug>(unite_quick_match_default_action)
    nmap <buffer> <C-z> <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-z> <Plug>(unite_toggle_transpose_window)
    imap <buffer> <C-y> <Plug>(unite_narrowing_path)
    nmap <buffer> <C-y> <Plug>(unite_narrowing_path)
    nmap <buffer> <C-j> <Plug>(unite_toggle_auto_preview)
    nmap <silent><buffer> <Tab> :call <SID>NextWindow()<CR>
    nnoremap <silent><buffer><expr> l
          \ unite#smart_map('l', unite#do_action('default'))
    nmap <buffer> <C-e> <Plug>(unite_narrowing_input_history)

    let unite = unite#get_current_unite()
    if unite.buffer_name =~# '^search'
      nnoremap <silent><buffer><expr> r unite#do_action('replace')
    else
      nnoremap <silent><buffer><expr> r unite#do_action('rename')
    endif

    nnoremap <silent><buffer><expr> cd unite#do_action('lcd')
    nnoremap <buffer><expr> S unite#mappings#set_current_filters(
          \ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
  endfunction
  "}}}

  " Variables.
  let g:unite_enable_split_vertically = 0
  let g:unite_winheight = 20
  let g:unite_enable_start_insert = 0

  let g:unite_cursor_line_highlight = 'TabLineSel'
  let g:unite_source_file_mru_filename_format = ':~:.'
  let g:unite_source_file_mru_limit = 300
  let g:unite_source_directory_mru_limit = 300

  if executable('ag')
    " Use ag in unite grep source.
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --column'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('jvgrep')
    " For jvgrep.
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts = '--exclude ''\.(git|svn|hg|bzr)'''
    let g:unite_source_grep_recursive_opt = '-R'
  elseif executable('ack-grep')
    " For ack.
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
    let g:unite_source_grep_recursive_opt = ''
  endif
endfunction

unlet bundle
"}}}

" vim-versions "{{{
nnoremap <silent> [Space]gs :<C-u>UniteVersions status:!<CR>
nnoremap <silent> [Space]gl :<C-u>UniteVersions log:%<CR>
" }}}

" neocomplcache.vim "{{{
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1

let bundle = neobundle#get('neocomplcache')
function! bundle.hooks.on_source(bundle)
  let g:neocomplcache_enable_smart_case = 0
  let g:neocomplcache_enable_camel_case_completion = 0
  let g:neocomplcache_enable_underbar_completion = 0
  let g:neocomplcache_enable_fuzzy_completion = 1
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_auto_completion_start_length = 2
  let g:neocomplcache_manual_completion_start_length = 0
  let g:neocomplcache_min_keyword_length = 3
  let g:neocomplcache_enable_cursor_hold_i = 0
  let g:neocomplcache_cursor_hold_i_time = 300
  let g:neocomplcache_enable_insert_char_pre = 0
  let g:neocomplcache_enable_prefetch = 0
  let g:neocomplcache_skip_auto_completion_time = '0.6'

  let g:neocomplcache_enable_auto_select = 1

  let g:neocomplcache_enable_auto_delimiter = 1
  let g:neocomplcache_max_list = 100
  let g:neocomplcache_force_overwrite_completefunc = 1
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif

  let g:neocomplcache_enable_auto_close_preview = 1

  let g:neocomplcache_dictionary_filetype_lists = {
        \   'default' : '',
        \   'scheme' : expand('~/.gosh_completions'),
        \   'scala' : expand('$DOTVIM/dict/scala.dict'),
        \   'ruby' : expand('$DOTVIM/dict/ruby.dict'),
        \   'sql' : expand('$DOTVIM/dict/sql.dict'),
        \   'int-termtter' : expand('~/.vimshell/int-history/int-termtter'),
        \ }

  let g:neocomplcache_omni_functions = {
        \   'ruby' : 'rubycomplete#Complete',
        \ }

  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '[0-9a-zA-Z:#_]\+'
  let g:neocomplcache_keyword_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.php = '[^. *\t]\.\w*\|\h\w*::'
  let g:neocomplcache_omni_patterns.mail = '^\s*\w\+'
  let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplcache_caching_limit_file_size = 500000

  if !exists('g:neocomplcache_same_filetype_lists')
    let g:neocomplcache_same_filetype_lists = {}
  endif

  "let g:neocomplcache#sources#rsense#home_directory = '/opt/rsense'

  let g:neocomplcache_vim_completefuncs = {
        \ 'Ref' : 'ref#complete',
        \ 'Unite' : 'unite#complete_source',
        \ 'VimShellExecute' :
        \      'vimshell#vimshell_execute_complete',
        \ 'VimShellInteractive' :
        \      'vimshell#vimshell_execute_complete',
        \ 'VimShellTerminal' :
        \      'vimshell#vimshell_execute_complete',
        \ 'VimShell' : 'vimshell#complete',
        \ 'VimFiler' : 'vimfiler#complete',
        \ 'Vinarise' : 'vinarise#complete',
        \}

  call neocomplcache#custom_source('look', 'min_pattern_length', 4)

  " mappings."{{{
  " <C-f>, <C-b>: page move.
  inoremap <expr><C-f> pumvisible() ? "\<PageDown>" : "\<Right>"
  inoremap <expr><C-b> pumvisible() ? "\<PageUp>"   : "\<Left>"

  " <C-y>: paste.
  inoremap <expr><C-y> pumvisible() ? neocomplcache#close_popup() : "\<C-r>\""

  " <C-e>: close popup.
  inoremap <expr><C-e> pumvisible() ? neocomplcache#cancel_popup() : "\<End>"

  " <C-k>: unite completion.
  imap <C-k> <Plug>(neocomplcache_start_unite_complete)

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"

  " <C-n>: neocomplcache.
  inoremap <expr><C-n> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>\<Down>"

  " <C-p>: keyword completion.
  inoremap <expr><C-p> pumvisible() ? "\<C-p>" : "\<C-p>\<C-n>"
  inoremap <expr>' pumvisible() ? neocomplcache#close_popup() : "'"

  inoremap <expr><C-x><C-f> neocomplcache#manual_filename_complete()

  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
  endfunction

  " <TAB>: completion.
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ neocomplcache#start_manual_complete()
  function! s:check_back_space() "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction"}}}

  " <S-TAB>: completion back.
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " For cursor moving in insert mode(Not recommended)
  inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
  inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
  inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
  inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
  "}}}
endfunction
unlet bundle
"}}}

" neosnippet.vim "{{{
autocmd MyAutoCmd FileType snippet setlocal noexpandtab

let bundle = neobundle#get('neosnippet')
function! bundle.hooks.on_source(bundle)
  imap <C-j> <Plug>(neosnippet_jump_or_expand)
  smap <C-j> <Plug>(neosnippet_jump_or_expand)
  xmap <C-j> <Plug>(neosnippet_expand_target)
  imap <C-s> <Plug>(neosnippet_start_unite_snippet)

  let g:neosnippet#enable_snipmate_compatibility = 1

  inoremap <expr><C-g> neocomplcache#undo_completion()
  inoremap <expr><C-l> neocomplcache#complete_common_string()

  let g:neosnippet#snippets_directory = '~/.vim/snippets'
endfunction
unlet bundle

nnoremap <silent> [Window]f :<C-u>Unite neosnippet/user neosnippet/runtime<CR>
"}}}

" vimfiler.vim "{{{
nnoremap <silent> [Space]v :<C-u>VimFiler<CR>
nnoremap [Space]ff :<C-u>VimFilerExplorer<CR>

let bundle = neobundle#get('vimfiler')
function! bundle.hooks.on_source(bundle)
  let g:vimfiler_enable_clipboard = 0
  let g:vimfiler_safe_mode_by_default = 0

  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_detect_drives = s:is_windows ? [
        \ 'C:/', 'D:/', 'E:/', 'F:/', 'G:/', 'H:/', 'I:/',
        \ 'J:/', 'K:/', 'L:/', 'M:/', 'N:/'] :
        \ split(glob('/mnt/*'), '\n') + split(glob('/media/*'), '\n') +
        \ split(glob('/Users/*'), '\n')

  if s:is_windows
    " Use trashbox.
    let g:unite_kind_file_use_trashbox = 1
  endif

  let g:vimfiler_quick_look_command =
        \ s:is_windows ? 'maComfort.exe -ql' :
        \ s:is_mac ? 'qlmanage -p' : 'gloobus-preview'

  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
  function! s:vimfiler_my_settings() "{{{
    call vimfiler#set_execute_file('vim', ['vim', 'notepad'])
    call vimfiler#set_execute_file('txt', 'vim')

    nnoremap <silent><buffer> J
          \ <C-u>:Unite -buffer-name=files -default-action=lcd directory_mru<CR>
    nmap <buffer> O <Plug>(vimfiler_sync_with_another_vimfiler)
    nnoremap <silent><buffer><expr> gy vimfiler#do_action('tabopen')
    nmap <buffer> p <Plug>(vimfiler_quick_look)
  endfunction
  "}}}
endfunction
unlet bundle
"}}}

" altercmd.vim "{{{
let bundle = neobundle#get('vim-altercmd')
function! bundle.hooks.on_source(bundle)
  call altercmd#load()

  AlterCommand <cmdwin> e[dit] Edit
  AlterCommand e[dit] Edit
  AlterCommand <cmdwin> r[ead] Read
  AlterCommand r[ead] Read
  AlterCommand <cmdwin> s[ource] Source
  AlterCommand s[ource] Source
  AlterCommand <cmdwin> w[rite] Write
  AlterCommand w[rite] Write
endfunction
unlet bundle
"}}}

" vimshell.vim "{{{
nmap <C-@> <Plug>(vimshell_switch)
nnoremap [Space]i q:VimShellInteractive<Space>
nnoremap [Space]t q:VimShellTerminal<Space>
nnoremap <silent> [Space]; <C-u>:VimShellPop<CR>

let bundle = neobundle#get('vimshell')
function! bundle.hooks.on_source(bundle)
  let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]%p", "(%s)-[%b|%a]%p")'
  let g:vimshell_prompt = '% '
  let g:vimshell_split_command = ''
  let g:vimshell_enable_transient_user_prompt = 1

  autocmd MyAutoCmd FileType vimshell call s:vimshell_settings()
  function! s:vimshell_settings()
    if s:is_windows
      let g:vimshell_use_terminal_command = 'ckw -e'
    else
      let g:vimshell_external_history_path = expand('~/.zsh-history')

      call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
      call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
      let g:vimshell_execute_file_list['zip'] = 'zipinfo'
      call vimshell#set_execute_file('tgz,gz', 'gzcat')
      call vimshell#set_execute_file('tbz,bz2', 'bzcat')

      let g:vimshell_use_terminal_command = 'gnome-terminal -e'
    endif

    let g:vimshell_execute_file_list = {}
    call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
    let g:vimshell_execute_file_list['rb'] = 'ruby'
    let g:vimshell_execute_file_list['pl'] = 'perl'
    let g:vimshell_execute_file_list['py'] = 'python'
    call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

    inoremap <buffer><expr>' pumvisible() ? "\<C-y>" : "'"
    imap <buffer><BS> <Plug>(vimshell_another_delete_backward_char)
    imap <buffer><C-h> <Plug>(vimshell_another_delete_backward_char)
    imap <buffer><C-k> <Plug>(vimshell_zsh_complete)

    nnoremap <silent><buffer> <C-j>
          \ <C-u>:Unite -buffer-name=files -default-action=lcd directory_mru<CR>

    call vimshell#altercmd#define('g', 'git')
    call vimshell#altercmd#define('i', 'iexe')
    call vimshell#altercmd#define('t', 'texe')
    call vimshell#set_alias('l.', 'ls -d .*')
    call vimshell#set_alias('gvim', 'gexe gvim')
    call vimshell#set_galias('L', 'ls -l')
    call vimshell#set_galias('time', 'exe time -p')

    " Auto jump.
    call vimshell#set_alias('j', ':Unite -buffer-name=files
          \ -default-action=lcd -no-split -input=$$args directory_mru')

    call vimshell#hook#add('chpwd', 'my_chpwd', s:vimshell_hooks.chpwd)
    call vimshell#hook#add('notfound', 'my_notfound', s:vimshell_hooks.notfound)
    call vimshell#hook#add('preprompt', 'my_preprompt', s:vimshell_hooks.preprompt)
    call vimshell#hook#add('preexec', 'my_preexec', s:vimshell_hooks.preexec)
  endfunction

  autocmd MyAutoCmd FileType int-* call s:interactive_settings()
  function! s:interactive_settings()
    call vimshell#hook#set('input', [s:vimshell_hooks.input])
  endfunction

  autocmd MyAutoCmd FileType term-* call s:terminal_settings()
  function! s:terminal_settings()
    inoremap <silent><buffer><expr> <Plug>(vimshell_term_send_semicolon)
          \ vimshell#term_mappings#send_key(';')
    inoremap <silent><buffer><expr> j<Space>
          \ vimshell#term_mappings#send_key('j')

    " Escape key.
    iunmap <buffer> <ESC><ESC>
    imap <buffer> <ESC> <Plug>(vimshell_term_send_escape)
  endfunction

  let s:vimshell_hooks = {}

  function! s:vimshell_hooks.chpwd(args, context)
    if len(split(glob('*'), '\n')) < 100
      call vimshell#execute('ls')
    else
      call vimshell#execute('echo "Many files."')
    endif
  endfunction

  function! s:vimshell_hooks.emptycmd(cmdline, context)
    call vimshell#set_prompt_command('ls')
    return 'ls'
  endfunction

  function! s:vimshell_hooks.notfound(cmdline, context)
    return ''
  endfunction

  function! s:vimshell_hooks.preprompt(args, context)
  endfunction

  function! s:vimshell_hooks.preexec(cmdline, context)
    let args = vimproc#parser#split_args(a:cmdline)
    if len(args) > 0 && args[0] ==# 'diff'
      call vimshell#set_syntax('diff')
    endif
    return a:cmdline
  endfunction

  function! s:vimshell_hooks.input(input, context)
    return a:input
  endfunction
endfunction
unlet bundle
"}}}

" surround.vim "{{{
let g:surround_no_mappings = 1
autocmd MyAutoCmd FileType * call s:define_surround_keymappings()

function! s:define_surround_keymappings()
  if !&l:modifiable
    silent! nunmap <buffer> ds
    silent! nunmap <buffer> cs
    silent! nunmap <buffer> ys
    silent! nunmap <buffer> yS
    silent! xunmap <buffer> s
    silent! xunmap <buffer> S
  else
    nmap <buffer> ds <Plug>Dsurround
    nmap <buffer> cs <Plug>Csurround
    nmap <buffer> ys <Plug>Ysurround
    nmap <buffer> yS <Plug>Ysurround$
    xmap <buffer> s  <Plug>Vsurround
    xmap <buffer> S  <Plug>VSurround
  endif
endfunction
"}}}

" operator-replace.vim "{{{
nmap R <Plug>(operator-replace)
xmap R <Plug>(operator-replace)
xmap p <Plug>(operator-replace)
"}}}

" operator-html-escape.vim "{{{
nmap <Leader>h <Plug>(operator-html-escape)
xmap <Leader>h <Plug>(operator-html-escape)
"}}}

" smartchr.vim "{{{
let bundle = neobundle#get('vim-smartchr')
function! bundle.hooks.on_source(bundle)
endfunction
unlet bundle
"}}}

" gundo.vim "{{{
nnoremap U :<C-u>GundoToggle<CR>
"}}}

" fontzoom.vim "{{{
nmap + <Plug>(fontzoom-larger)
nmap _ <Plug>(fontzoom-smaller)
"}}}

" qfreplace.vim "{{{
autocmd MyAutoCmd FileType qf nnoremap <buffer> r :<C-u>Qfreplace<CR>
"}}}

" visualstar "{{{
map *  <Plug>(visualstar-*)zv
map #  <Plug>(visualstar-#)zv
map g* <Plug>(visualstar-g*)zv
map g# <Plug>(visualstar-g#)zv
"}}}

" errormarker.vim "{{{
let g:errormarker_errortext    = "!!"
let g:errormarker_warningtext  = "??"
let g:errormarker_errorgroup   = "Error"
let g:errormarker_warninggroup = "Todo"
"}}}

" quickrun.vim "{{{
function! s:init_quickrun()
  for [key, com] in items({
        \   '<Leader>x' : '<=@i >:',
        \   '<Leader>p' : '<=@i >!',
        \   '<Leader>"' : '<=@i >=@"',
        \   '<Leader>w' : '<=@i >',
        \   '<Leader>q' : '<=@i >>',
        \   '<Leader>vx' : '-eval 1 <=@i >:',
        \   '<Leader>vp' : '-eval 1 <=@i >!',
        \   '<Leader>v"' : '-eval 1 <=@i >=@"',
        \   '<Leader>vw' : '-eval 1 <=@i >',
        \   '<Leader>vq' : '-eval 1 <=@i >>',
        \ })
    execute 'nnoremap <silent>' key ':QuickRun' com '-mode n<CR>'
    execute 'vnoremap <silent>' key ':QuickRun' com '-mode v<CR>'
  endfor
endfunction
call s:init_quickrun()
nmap <silent> <Leader>r <Plug>(quickrun)

if !exists('g:quickrun_config')
  let g:quickrun_config = {}
  let g:quickrun_config._ = { 'runner': 'vimproc' }
  let g:quickrun_config.markdown = { 'outputter': 'browser' }
endif
"}}}

" zencoding "{{{
let g:user_zen_leader_key = '<c-y>'
let g:use_zen_complete_tag = 1
let g:user_zen_settings = {
      \  'lang' : 'ja',
      \  'html' : {
      \    'filters' : 'html',
      \    'indentation' : ' '
      \  },
      \  'perl' : {
      \    'indentation' : '  ',
      \    'aliases' : {
      \      'req' : "require '|'"
      \    },
      \    'snippets' : {
      \      'use' : "use strict\nuse warnings\n\n",
      \      'w' : "warn \"${cursor}\";",
      \    },
      \  },
      \  'php' : {
      \    'extends' : 'html',
      \    'filters' : 'html,c',
      \  },
      \  'css' : {
      \    'filters' : 'fc',
      \  },
      \  'javascript' : {
      \    'snippets' : {
      \      'jq' : "$(function() {\n\t${cursor}${child}\n});",
      \      'jq:each' : "$.each(arr, function(index, item)\n\t${child}\n});",
      \      'fn' : "(function() {\n\t${cursor}\n})();",
      \      'tm' : "setTimeout(function() {\n\t${cursor}\n}, 100);",
      \    },
      \  },
      \  'java' : {
      \    'indentation' : '    ',
      \    'snippets' : {
      \      'main': "public static void main(String[] args) {\n\t|\n}",
      \      'println': "System.out.println(\"|\");",
      \      'class': "public class | {\n}\n",
      \    },
      \  },
      \}
"}}}

" switch.vim "{{{
nnoremap <silent> ! :Switch<cr>
"}}}

" echodoc.vim "{{{
let bundle = neobundle#get('echodoc')
function! bundle.hooks.on_source(bundle)
  let g:echodoc_enable_at_startup = 1
endfunction
unlet bundle
"}}}

" camlcasemotion.vim "{{{
nmap <silent> [Alt]w <Plug>CamelCaseMotion_w
xmap <silent> [Alt]w <Plug>CamelCaseMotion_w
omap <silent> [Alt]w <Plug>CamelCaseMotion_w
nmap <silent> [Alt]b <Plug>CamelCaseMotion_b
xmap <silent> [Alt]b <Plug>CamelCaseMotion_b
omap <silent> [Alt]b <Plug>CamelCaseMotion_b
""}}}

" vim-niceblock "{{{
vmap I <Plug>(niceblock-I)
vmap A <Plug>(niceblock-A)
"}}}

" smarttill.vim "{{{
xmap <Leader>t <Plug>(smarttill-t)
xmap <Leader>T <Plug>(smarttill-T)
omap <Leader>t <Plug>(smarttill-t)
omap <Leader>T <Plug>(smarttill-T)
"}}}

" smartword.vim "{{{
nmap w  <Plug>(smartword-w)
nmap b  <Plug>(smartword-b)
nmap ge <Plug>(smartword-ge)
xmap w  <Plug>(smartword-w)
xmap b  <Plug>(smartword-b)
omap <Leader>w  <Plug>(smartword-w)
omap <Leader>b  <Plug>(smartword-b)
omap <Leader>ge <Plug>(smartword-ge)
"}}}

" tabpagecd "{{{
autocmd MyAutoCmd TabEnter * NeoBundleSource vim-tabpagecd
"}}}

" accelerated-jk "{{{
if neobundle#is_installed('accelerated-jk')
  " accelerated-jk
  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap gj j
  nmap <silent>k <Plug>(accelerated_jk_gk)
  nmap gk k
endif
"}}}

" caw.vim "{{{
autocmd MyAutoCmd FileType * call s:init_caw()
function! s:init_caw()
  if !&l:modifiable
    silent! nunmap <buffer> gc
    silent! xunmap <buffer> gc
    silent! nunmap <buffer> gcc
    silent! xunmap <buffer> gcc

    return
  endif

  nmap <buffer> gc <Plug>(caw:prefix)
  xmap <buffer> gc <Plug>(caw:prefix)
  nmap <buffer> gcc <Plug>(caw:i:toggle)
  xmap <buffer> gcc <Plug>(caw:i:toggle)
endfunction
"}}}

" restart.vim "{{{
let g:restart_save_window_values = 0
nnoremap <silent> [Space]re  :<C-u>Restart<CR>
"}}}

" autofmt "{{{
set formatexpr=autofmt#japanese#formatexpr()
"}}}

" ref.vim "{{{
let bundle = neobundle#get('vim-ref')
function! bundle.hooks.on_source(bundle)
  let g:ref_use_vimproc = 1
  if s:is_windows
    let g:ref_refe_encoding = 'cp932'
  else
    let g:ref_refe_encoding = 'euc-jp'
  endif

  " ref-lynx.
  if s:is_windows
    let lynx = 'C:/lynx/lynx.exe'
    let cfg  = 'C:/lynx/lynx.cfg'
    let g:ref_lynx_cmd = s:lynx.' -cfg='.s:cfg.' -dump -nonumbers %s'
    let g:ref_alc_cmd = s:lynx.' -cfg='.s:cfg.' -dump %s'
  endif

  let g:ref_lynx_use_cache = 1
  let g:ref_lynx_start_linenumber = 0 " Skip.
  let g:ref_lynx_hide_url_number = 0

  autocmd MyAutoCmd FileType ref call s:ref_my_settings()
  function! s:ref_my_settings() "{{{
    nmap <buffer> [Tag]t <Plug>(ref-keyword)
    nmap <buffer> [Tag]p <Plug>(ref-back)
  endfunction
  "}}}
endfunction

unlet bundle
"}}}

" autodate.vim "{{{
let autodate_format = '%Y/%m/%d'
let autodate_keyword_pre = 'Last \%(Change\|Modified\):'
"}}}

" vinarise.vim "{{{
let g:vinarise_enable_auto_detect = 1
"}}}

" netrw.vim"{{{
let g:netrw_list_hide= '*.swp'
nnoremap <silent> <BS> :<C-u>Explore<CR>
" Change default directory.
set browsedir=current
"}}}

" open-browser.vim"{{{
nmap gs <Plug>(open-browser-wwwsearch)

let bundle = neobundle#get('open-browser.vim')
function! bundle.hooks.on_source(bundle)
  nnoremap <Plug>(open-browser-wwwsearch)
        \ :<C-u>call <SID>www_search()<CR>
  function! s:www_search()
    let search_word = input('Please input search word: ', '',
          \ 'customlist,wwwsearch#cmd_Wwwsearch_complete')
    if search_word != ''
      execute 'OpenBrowserSearch' escape(search_word, '"')
    endif
  endfunction
endfunction

unlet bundle
"}}}

" vim-submode "{{{
let g:submode_leave_with_key = 1

call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')

call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'T', 'gT')

call submode#enter_with('undo/redo', 'n', '', 'g-', 'g-')
call submode#enter_with('undo/redo', 'n', '', 'g+', 'g+')
call submode#map('undo/redo', 'n', '', '-', 'g-')
call submode#map('undo/redo', 'n', '', '+', 'g+')
"}}}

" junkfile.vim "{{{
nnoremap <silent> [Window]e :<C-u>Unite junkfile/new junkfile -start-insert<CR>
"}}}

"}}}

" Commands: "{{{

" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>

" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

" Rename file
command! -nargs=1 -bang -bar -complete=file Rename saveas<bang> <args> | call delete(expand('#:p'))

"}}}

" Functions: "{{{

" Toggle options. "{{{
function! ToggleOption(option_name)
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction
"}}}

" Toggle variables. "{{{
function! ToggleVariable(variable_name)
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
  echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction
"}}}

function! SnipMid(str, len, mask) "{{{
  if a:len >= len(a:str)
    return a:str
  elseif a:len <= len(a:mask)
    return a:mask
  endif

  let len_head = (a:len - len(a:mask)) / 2
  let len_tail = a:len - len(a:mask) - len_head

  return (len_head > 0 ? a:str[: len_head - 1] : '')
        \ . a:mask . (len_tail > 0 ? a:str[-len_tail :] : '')
endfunction
"}}}

"}}}

" Platform depends: "{{{

if !s:is_windows
   " Zshを使う
   set shell=zsh
endif

if !has('gui_running') && !exists('g:colors_name')
   " 色数設定
  if !exists('$TMUX')
    set t_Co=256
  endif

  if has('gui')
    NeoBundleSource csapprox

    let g:CSApprox_konsole = 1
    let g:CSApprox_attr_map = {
          \ 'bold' : 'bold',
          \ 'italic' : '', 'sp' : ''
          \ }
    if !exists('g:colors_name')
      colorscheme xoria256
    endif
  else
    NeoBundleSource vim-guicolorscheme

    autocmd MyAutoCmd VimEnter,BufAdd *
          \ if !exists('g:colors_name') | GuiColorScheme xoria256

    let g:CSApprox_verbose_level = 0
  endif
endif

if exists('+macmeta')
   " MacVimでMETAキーを使えるようにする
   set macmeta
endif

"}}}

" Others: "{{{

" マウスを利用可能にする
if has('mouse')
  set mouse=a
  if has('mouse_sgr') || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" 日本語ヘルプを優先
set helplang=ja

" Don't calc octal.
set nrformats& nrformats-=octal

" Default home directory.
let t:cwd = getcwd()
"}}}

if !has('vim_starting')
  call neobundle#call_hook('on_source')
endif

set secure

" vim: foldmethod=marker fileencoding=utf-8
