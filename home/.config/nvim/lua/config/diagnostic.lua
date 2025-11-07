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
    float = true,
  },
})
