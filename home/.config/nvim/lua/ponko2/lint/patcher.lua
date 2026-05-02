local fs = require('ponko2.fs')

local M = {}

--- Wraps a linter to prefer the local .venv binary, using `uv run -m` if available.
---@param linter lint.Linter | fun(): lint.Linter
---@return fun(): lint.Linter
function M.apply_for_venv(linter)
  return function()
    if type(linter) == 'function' then
      linter = linter()
    end
    local cmd = fs.resolve_venv_cmd(linter.cmd, vim.api.nvim_buf_get_name(0))
    if cmd == linter.cmd then
      return linter
    end
    if vim.fn.executable('uv') == 1 then
      return vim.tbl_extend('force', linter, {
        cmd = 'uv',
        args = vim.list_extend({ 'run', '-m', linter.cmd }, linter.args or {}),
      })
    end
    return vim.tbl_extend('force', linter, { cmd = cmd })
  end
end

return M
