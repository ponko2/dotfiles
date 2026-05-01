local fs = require('ponko2.fs')

---@param source string?
---@return string
local function resolve_cmd(source)
  return fs.resolve_venv_cmd('ruff', source)
end

return {
  cmd = function(dispatchers, config)
    local cmd = resolve_cmd((config or {}).root_dir)
    return vim.lsp.rpc.start({ cmd, 'server' }, dispatchers)
  end,
  root_dir = function(bufnr, on_dir)
    --- Each marker is tried depth-first (all ancestors before next marker),
    --- matching the behavior of `root_markers` in vim.lsp.start().
    --- refs: https://github.com/neovim/neovim/blob/b877aa3/runtime/lua/vim/lsp.lua#L726-L732
    local root_markers = {
      '.ruff.toml',
      'ruff.toml',
      fs.file_contains_any({ 'pyproject.toml' }, { 'ruff' }),
    }
    for _, marker in ipairs(root_markers) do
      local root = vim.fs.root(bufnr, marker)
      if root then
        if vim.fn.executable(resolve_cmd(root)) == 1 then
          on_dir(root)
        end
        return
      end
    end
  end,
}
