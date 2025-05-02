if os.getenv('SHELL'):match('/?zsh$') then
  local pattern = vim.tbl_filter(
    ---@param item string?
    function(item)
      return not not item
    end,
    { os.getenv('HISTFILE'), '.zsh_history' }
  )
  vim.api.nvim_create_autocmd('BufReadCmd', {
    pattern = pattern,
    callback = function()
      vim.bo.buftype = 'acwrite'
      vim.bo.filetype = 'zsh'
      require('histfile').read()
    end,
  })
  vim.api.nvim_create_autocmd('BufWriteCmd', {
    pattern = pattern,
    callback = function()
      require('histfile').write()
    end,
  })
end
