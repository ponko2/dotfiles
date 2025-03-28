--------------------------------------------------------------------------------
-- Options:
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Search:

-- 大文字と小文字を無視する
vim.opt.ignorecase = true

-- 検索パターンが大文字を含んでいたらオプション ignorecase を無効にする
vim.opt.smartcase = true

--------------------------------------------------------------------------------
-- Edit:

-- タブをスペースにする
vim.opt.expandtab = true

-- smart indentを有効にする
vim.opt.smartindent = true

-- インデントをshiftwidthの倍数に丸める
vim.opt.shiftround = true

-- 最終行への <EOL> 追加を無効化
vim.opt.fixendofline = false

-- クリップボードレジスタを使う
if vim.fn.has('unnamedplus') == 1 then
  vim.cmd([[set clipboard& clipboard^=unnamedplus]])
else
  vim.cmd([[set clipboard& clipboard^=unnamed]])
end

-- BackSpaceの挙動を設定
vim.opt.backspace = { 'indent', 'eol', 'nostop' }

-- 対応する括弧の表示
vim.opt.showmatch = true

if vim.fn.exists('g:loaded_matchit') == 0 then
  vim.cmd([[packadd! matchit]])
end

-- バックアップ設定
vim.opt.backup = true
vim.opt.backupdir:remove('.')

-- vimを終了してもundo履歴を復元する
vim.opt.undofile = true

-- Visual blockモードで仮想編集を有効にする
vim.opt.virtualedit = 'block'

--------------------------------------------------------------------------------
-- View:

-- 特殊文字を可視化
vim.opt.list = true
if vim.opt.encoding:get() == 'utf-8' then
  vim.opt.listchars = { tab = '￫ ', multispace = '･', lead = '･', trail = '･', nbsp = '+' }
else
  vim.opt.listchars = { tab = '> ', multispace = '-', lead = '-', trail = '-', nbsp = '+' }
end

-- タイトルを表示する
vim.opt.title = true

-- Set statusline.
vim.opt.statusline = "%{winnr('$') > 1 ? '[' .. winnr() .. '/' .. winnr('$')"
  .. " .. (winnr('#') ==# winnr() ? '#' : '') .. ']' : ''} "
  .. "%{(&previewwindow ? '[Preview] ' : '') .. expand('%:t')} "
  .. "%=%{(winnr('$') ==# 1 || winnr('#') !=# winnr()) ? "
  .. "'[' .. (&filetype !=# '' ? &filetype .. ',' : '')"
  .. " .. (&fenc !=# '' ? &fenc : &enc) .. ',' .. &ff .. ']' : ''}"
  .. "%m%{printf('%' .. (len(line('$')) + 2) .. 'd/%d', line('.'), line('$'))}"

-- 折り返し表示の設定
vim.opt.linebreak = true
vim.opt.showbreak = '> '

-- 折り返し設定
vim.cmd('set whichwrap& whichwrap+=b,s,h,l,<,>,~,[,]')
vim.opt.wrap = false
vim.opt.breakindent = true

-- コマンドライン補完
vim.opt.wildignorecase = true
vim.cmd([[set wildoptions& wildoptions+=fuzzy]])

-- Display all the information of the tag by the supplement of the Insert mode.
vim.opt.showfulltag = true

-- Disable menu
vim.g.did_install_default_menus = 1

if vim.opt.verbose:get() == 0 then
  -- US英語のスペルチェックを有効化
  vim.opt.spelllang:remove('en')
  vim.opt.spelllang:append('en_us')

  -- スペルチェックから日本語を除外
  vim.opt.spelllang:append('cjk')
end

-- 補完定設
vim.opt.completeopt:remove('menu')
vim.opt.completeopt:prepend({ 'menu', 'menuone' })
vim.opt.completeopt:append({ 'noselect', 'popup' })

-- 補完のポップアップメニュー最大表示件数
vim.opt.pumheight = 20

-- 変更された行の数を報告
vim.opt.report = 0

-- ウィンドウを横分割した際、新しいウィンドウはカレントウィンドウの下に開く
vim.opt.splitbelow = true

-- ウィンドウを縦分割した際、新しいウィンドウはカレントウィンドウの右に開く
vim.opt.splitright = true

-- ウィンドウを分割したり閉じたりした時、全てのウィンドウを自動的に同じサイズにしない
vim.opt.equalalways = false

-- View setting.
vim.cmd([[set viewoptions& viewoptions-=options viewoptions+=slash,unix]])

-- Conceal表示
vim.opt.concealcursor = 'nc'
vim.opt.conceallevel = 2

-- 指定した列を強調表示
vim.opt.colorcolumn = '119'

-- Enable true color
if vim.fn.exists('+termguicolors') == 1 then
  vim.opt.termguicolors = true
end

if vim.fn.exists('&pumblend') == 1 then
  vim.opt.pumblend = 20
end

if vim.fn.exists('&winblend') == 1 then
  vim.opt.winblend = 20
end

--------------------------------------------------------------------------------
-- Others:

-- Don't calc octal.
vim.cmd([[set nrformats& nrformats+=unsigned]])
