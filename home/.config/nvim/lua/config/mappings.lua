--------------------------------------------------------------------------------
-- Key-mappings:
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Normal mode keymappings:

-- 検索の強調表示を無効化
vim.keymap.set('n', '<C-l>', [[<Cmd>nohlsearch<CR><C-l>]])

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
