--------------------------------------------------------------------------------
-- Autocmds:
--------------------------------------------------------------------------------

-- Create augroup
local id = vim.api.nvim_create_augroup('MyAutoCmd', { clear = true })

-- ファイルの変更を検知してバッファを再読み込み
vim.api.nvim_create_autocmd({ 'FocusGained', 'WinEnter', 'CursorHold', 'CursorHoldI' }, {
  group = id,
  pattern = '*',
  command = [[if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif]],
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = id,
  pattern = '*',
  callback = function()
    vim.api.nvim_echo({ { 'File changed on disk. Buffer reloaded.', 'WarningMsg' } }, true, {})
  end,
})

-- quickfixウィンドウを自動で開く
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = id,
  pattern = { 'make', 'grep', 'grepadd', 'vimgrep' },
  command = [[tab cwindow]],
})

-- Disable paste.
vim.api.nvim_create_autocmd('InsertLeave', {
  group = id,
  pattern = '*',
  command = [[if &paste | setlocal nopaste | echo 'nopaste' | endif | if &l:diff | diffupdate | endif]],
})

-- Update diff.
vim.api.nvim_create_autocmd('InsertLeave', {
  group = id,
  pattern = '*',
  command = [[if &l:diff | diffupdate | endif]],
})

-- Make directory automatically.
vim.api.nvim_create_autocmd('BufWritePre', {
  group = id,
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if
      vim.fn.isdirectory(dir) == 0
      and vim.opt_local.buftype:get() == ''
      and (
        vim.v.cmdbang == 1
        or vim
          .regex([[\c^y\%[es]$]])
          :match_str(vim.fn.input(('"%s" does not exist. Create? [y/N]: '):format(dir)))
      )
    then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- コメントの自動挿入をしない
vim.api.nvim_create_autocmd({ 'FileType', 'Syntax', 'BufEnter', 'BufWinEnter' }, {
  group = id,
  pattern = '*',
  command = [[setlocal formatoptions-=r formatoptions-=o formatoptions+=mM]],
})
