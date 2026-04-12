if os.getenv('SHELL'):match('/?zsh$') then
  local pattern = {
    '**/.zsh_history',
    '**/.zsh_history.*',
    '**/zsh/history',
    '**/zsh/history.*',
  }
  vim.api.nvim_create_autocmd('BufReadCmd', {
    pattern = pattern,
    ---@param ev { buf: integer }
    callback = function(ev)
      vim.bo[ev.buf].buftype = 'acwrite'
      vim.bo[ev.buf].filetype = 'zsh'
      require('histfile').read(ev.buf)
    end,
  })
  vim.api.nvim_create_autocmd('BufWriteCmd', {
    pattern = pattern,
    ---@param ev { buf: integer }
    callback = function(ev)
      require('histfile').write(ev.buf)
    end,
  })
end
