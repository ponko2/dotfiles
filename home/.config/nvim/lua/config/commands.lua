--------------------------------------------------------------------------------
-- Commands:
--------------------------------------------------------------------------------

-- grep
vim.api.nvim_create_user_command('Grep', function(opts)
  vim.cmd(([[silent grep! "%s"]]):format(vim.fn.escape(opts.args, '"')))
  vim.cmd([[redraw!]])
end, { nargs = '+' })
vim.api.nvim_create_user_command('GrepAdd', function(opts)
  vim.cmd(([[silent grepadd! "%s"]]):format(vim.fn.escape(opts.args, '"')))
  vim.cmd([[redraw!]])
end, { nargs = '+' })

-- Trim trailing whitespace
vim.api.nvim_create_user_command('TrimTrailingWhitespace', function(opts)
  local view = vim.fn.winsaveview()
  vim.cmd(([[keepjumps keeppatterns %d,%ds/[[:space:]　]\+$//e]]):format(opts.line1, opts.line2))
  vim.fn.winrestview(view)
end, { range = '%' })
