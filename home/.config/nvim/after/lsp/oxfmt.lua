local fs = require('ponko2.fs')

---@param source string?
---@return string
local function resolve_cmd(source)
  return fs.resolve_node_cmd('oxfmt', source)
end

return {
  cmd = function(dispatchers, config)
    local cmd = resolve_cmd((config or {}).root_dir)
    return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
  end,
  root_dir = function(bufnr, on_dir)
    --- Each marker is tried depth-first (all ancestors before next marker),
    --- matching the behavior of `root_markers` in vim.lsp.start().
    --- refs: https://github.com/neovim/neovim/blob/b877aa3/runtime/lua/vim/lsp.lua#L726-L732
    local root_markers = {
      '.oxfmtrc.json',
      '.oxfmtrc.jsonc',
      'oxfmt.config.ts',
      fs.file_contains_any({ 'vite.config.js', 'vite.config.ts' }, { 'vite%-plus' }),
      fs.file_contains_any({ 'package.json', 'package.json5' }, { 'oxfmt', 'vite%-plus' }),
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
