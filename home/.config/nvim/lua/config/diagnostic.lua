--------------------------------------------------------------------------------
-- Diagnostic:
--------------------------------------------------------------------------------

vim.diagnostic.handlers.loclist = {
  ---@param opts { loclist: vim.diagnostic.setloclist.Opts }
  show = function(_, _, _, opts)
    -- Generally don't want it to open on every update
    opts.loclist.open = opts.loclist.open or false
    local winid = vim.api.nvim_get_current_win()
    vim.diagnostic.setloclist(opts.loclist)
    vim.api.nvim_set_current_win(winid)
  end,
}

vim.diagnostic.config({
  float = {
    border = 'rounded',
    source = true,
  },
  jump = {
    --- @param diagnostic? vim.Diagnostic
    --- @param bufnr integer
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
