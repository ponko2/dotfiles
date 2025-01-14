--------------------------------------------------------------------------------
-- Key-mappings:
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Normal mode keymappings:

-- 検索の強調表示を無効化
vim.keymap.set('n', '<C-l>', [[<Cmd>nohlsearch<CR><C-l>]])

-- 引数リスト移動
vim.keymap.set('n', '[a', [[<Cmd>previous<CR>]], { desc = 'Previous argument' })
vim.keymap.set('n', ']a', [[<Cmd>next<CR>]], { desc = 'Next argument' })
vim.keymap.set('n', '[A', [[<Cmd>first<CR>]], { desc = 'First argument' })
vim.keymap.set('n', ']A', [[<Cmd>last<CR>]], { desc = 'Last argument' })

-- バッファリスト移動
vim.keymap.set('n', '[b', [[<Cmd>bprevious<CR>]], { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', [[<Cmd>bnext<CR>]], { desc = 'Next buffer' })
vim.keymap.set('n', '[B', [[<Cmd>bfirst<CR>]], { desc = 'First buffer' })
vim.keymap.set('n', ']B', [[<Cmd>blast<CR>]], { desc = 'Last buffer' })

-- ロケーションリスト移動
vim.keymap.set('n', '[l', function()
  xpcall(function()
    vim.cmd.lprevious()
  end, function()
    vim.cmd.llast()
  end)
end, { desc = 'Previous location' })
vim.keymap.set('n', ']l', function()
  xpcall(function()
    vim.cmd.lnext()
  end, function()
    vim.cmd.lfirst()
  end)
end, { desc = 'Next location' })
vim.keymap.set('n', '[L', [[<Cmd>lfirst<CR>]], { desc = 'First location' })
vim.keymap.set('n', ']L', [[<Cmd>llast<CR>]], { desc = 'Last location' })

-- エラーリスト移動
vim.keymap.set('n', '[q', function()
  xpcall(function()
    vim.cmd.cprevious()
  end, function()
    vim.cmd.clast()
  end)
end, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', function()
  xpcall(function()
    vim.cmd.cnext()
  end, function()
    vim.cmd.cfirst()
  end)
end, { desc = 'Next quickfix' })
vim.keymap.set('n', '[Q', [[<Cmd>cfirst<CR>]], { desc = 'First quickfix' })
vim.keymap.set('n', ']Q', [[<Cmd>clast<CR>]], { desc = 'Last quickfix' })

-- タグリスト移動
vim.keymap.set('n', '[t', [[<Cmd>tprevious<CR>]], { desc = 'Previous tag' })
vim.keymap.set('n', ']t', [[<Cmd>tnext<CR>]], { desc = 'Next tag' })
vim.keymap.set('n', '[T', [[<Cmd>tfirst<CR>]], { desc = 'First tag' })
vim.keymap.set('n', ']T', [[<Cmd>tlast<CR>]], { desc = 'Last tag' })

-- Better x
vim.keymap.set('n', 'x', [["_x]])

-- Better Y
vim.keymap.set('n', 'Y', [[y$]])

-- grep
vim.keymap.set('n', '<Leader>/', [[:<C-u>Grep<Space>]], { desc = 'Grep' })

--------------------------------------------------------------------------------
-- Command-line mode keymappings:

-- Next history.
vim.keymap.set('c', '<Down>', function()
  if vim.fn.pumvisible() == 1 then
    return '<Down>'
  else
    return '<C-n>'
  end
end, { expr = true })
vim.keymap.set('c', '<C-n>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  else
    return '<Down>'
  end
end, { expr = true })

-- Previous history.
vim.keymap.set('c', '<Up>', function()
  if vim.fn.pumvisible() == 1 then
    return '<Up>'
  else
    return '<C-p>'
  end
end, { expr = true })
vim.keymap.set('c', '<C-p>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  else
    return '<Up>'
  end
end, { expr = true })

-- %% -> %:h/
vim.keymap.set('c', '%%', function()
  if vim.fn.getcmdtype() == ':' then
    return vim.fn.expand('%:h') .. '/'
  else
    return '%%'
  end
end, { expr = true })

--------------------------------------------------------------------------------
-- Visual mode keymappings:

-- Disable dos-standard-mappings
vim.cmd([[silent! vunmap <C-x>]])

--------------------------------------------------------------------------------
-- Terminal keymappings:

if vim.fn.exists(':tnoremap') == 2 then
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])
end

--------------------------------------------------------------------------------
-- VSCode keymappings:

if vim.g.vscode then
  -- タブ移動
  vim.keymap.set(
    'n',
    '[b',
    [[<Cmd>lua require('vscode').call('workbench.action.previousEditor')<CR>]]
  )
  vim.keymap.set('n', ']b', [[<Cmd>lua require('vscode').call('workbench.action.nextEditor')<CR>]])
  vim.keymap.set(
    'n',
    '[B',
    [[<Cmd>lua require('vscode').call('workbench.action.firstEditorInGroup')<CR>]]
  )
  vim.keymap.set(
    'n',
    ']B',
    [[<Cmd>lua require('vscode').call('workbench.action.lastEditorInGroup')<CR>]]
  )

  -- 変更移動
  vim.keymap.set('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal({ '[c', bang = true })
    else
      require('vscode').call('workbench.action.editor.previousChange')
    end
  end)
  vim.keymap.set('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal({ ']c', bang = true })
    else
      require('vscode').call('workbench.action.editor.nextChange')
    end
  end)

  -- Diagnostics
  vim.keymap.set(
    'n',
    '[d',
    [[<Cmd>lua require('vscode').call('editor.action.marker.prevInFiles')<CR>]]
  )
  vim.keymap.set(
    'n',
    ']d',
    [[<Cmd>lua require('vscode').call('editor.action.marker.nextInFiles')<CR>]]
  )

  -- Show Explorer
  vim.keymap.set(
    'n',
    '<Leader>fe',
    [[<Cmd>lua require('vscode').call('workbench.view.explorer')<CR>]]
  )

  -- Go to File...
  vim.keymap.set(
    'n',
    '<Leader>ff',
    [[<Cmd>lua require('vscode').call('workbench.action.quickOpen')<CR>]]
  )

  -- Show Search
  vim.keymap.set(
    'n',
    '<Leader>f/',
    [[<Cmd>lua require('vscode').call('workbench.view.search')<CR>]]
  )
  vim.keymap.set(
    'n',
    '<Leader>fg',
    [[<Cmd>lua require('vscode').call('workbench.view.search')<CR>]]
  )

  -- Comment
  vim.keymap.set({ 'n', 'x', 'o' }, 'gc', [[<Plug>VSCodeCommentary]])
  vim.keymap.set('n', 'gcc', [[<Plug>VSCodeCommentaryLine]])
end
