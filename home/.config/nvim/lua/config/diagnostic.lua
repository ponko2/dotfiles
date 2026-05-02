--------------------------------------------------------------------------------
-- Diagnostic:
--------------------------------------------------------------------------------

vim.diagnostic.handlers.loclist = {
  ---@param bufnr integer
  ---@param opts { loclist: vim.diagnostic.setloclist.Opts }
  show = function(_, bufnr, _, opts)
    if vim.bo.buftype ~= '' then
      return
    end
    -- Generally don't want it to open on every update
    opts.loclist.open = opts.loclist.open or false
    local winIds = vim.fn.win_findbuf(bufnr)
    if #winIds > 0 then
      local winid = vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win(winIds[1])
      vim.diagnostic.setloclist(opts.loclist)
      vim.api.nvim_set_current_win(winid)
    end
  end,
  ---@param bufnr integer
  hide = function(_, bufnr)
    if vim.bo.buftype ~= '' then
      return
    end
    local winIds = vim.fn.win_findbuf(bufnr)
    if #winIds > 0 then
      local winid = vim.api.nvim_get_current_win()
      vim.api.nvim_set_current_win(winIds[1])
      vim.diagnostic.setloclist({ open = false })
      vim.api.nvim_set_current_win(winid)
    end
  end,
}

vim.diagnostic.config({
  float = {
    border = 'rounded',
    source = true,
  },
  jump = {
    ---@param diagnostic? vim.Diagnostic
    ---@param bufnr integer
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then
        return
      end
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      })
    end,
  },
})
