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

-- Yank agent context
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>ay',
  '<Cmd>YankAgentContext<CR>',
  { desc = 'Yank agent context (range)' }
)
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>aY',
  '<Cmd>YankAgentContext!<CR>',
  { desc = 'Yank agent context (file)' }
)

-- cd to git root
vim.keymap.set('n', '<Leader>gt', '<Cmd>CdGitRoot<CR>', { desc = 'cd to git root' })

-- undotree
vim.keymap.set('n', '<Leader>u', '<Cmd>Undotree<CR>', { desc = 'undotree' })

--------------------------------------------------------------------------------
-- Command-line mode keymappings:

-- Next history.
vim.keymap.set('c', '<Down>', function()
  if vim.fn.pumvisible() == 1 then
    return '<Down>'
  end
  return '<C-n>'
end, { expr = true })
vim.keymap.set('c', '<C-n>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  end
  return '<Down>'
end, { expr = true })

-- Previous history.
vim.keymap.set('c', '<Up>', function()
  if vim.fn.pumvisible() == 1 then
    return '<Up>'
  end
  return '<C-p>'
end, { expr = true })
vim.keymap.set('c', '<C-p>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  end
  return '<Up>'
end, { expr = true })

-- %% -> %:h/
vim.keymap.set('c', '%%', function()
  if vim.fn.getcmdtype() == ':' then
    return vim.fn.expand('%:h') .. '/'
  end
  return '%%'
end, { expr = true })

--------------------------------------------------------------------------------
-- Insert mode keymappings:

vim.keymap.set('i', '<CR>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-y>'
  end
  return '<CR>'
end, { expr = true })

vim.keymap.set('i', '<Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  end
  return '<Tab>'
end, { expr = true })

vim.keymap.set('i', '<S-Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-p>'
  end
  return '<S-Tab>'
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
