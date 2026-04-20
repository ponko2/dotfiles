local util = require 'lsp.util'

return {
  cmd = function(dispatchers, config)
    local cmd = 'oxfmt'
    if (config or {}).root_dir then
      local package_root = vim.fs.root(
        config.root_dir,
        util.file_contains_any({ 'package.json', 'package.json5' }, { 'oxfmt', 'vite%-plus' })
      )
      if package_root then
        local local_cmd = vim.fs.joinpath(package_root, 'node_modules/.bin', cmd)
        if vim.fn.executable(local_cmd) == 1 then
          cmd = local_cmd
        end
      end
    end
    return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
  end,
  root_dir = function(bufnr, on_dir)
    --- Each marker is tried depth-first (all ancestors before next marker),
    --- matching the behavior of `root_markers` in vim.lsp.start().
    --- @see https://github.com/neovim/neovim/blob/b877aa3/runtime/lua/vim/lsp.lua#L726-L732
    local root_markers = {
      '.oxfmtrc.json',
      '.oxfmtrc.jsonc',
      'oxfmt.config.ts',
      util.file_contains_any({ 'vite.config.js', 'vite.config.ts' }, { 'vite%-plus' }),
      util.file_contains_any({ 'package.json', 'package.json5' }, { 'oxfmt', 'vite%-plus' }),
    }
    for _, marker in ipairs(root_markers) do
      local root = vim.fs.root(bufnr, marker)
      if root then
        on_dir(root)
        return
      end
    end
  end,
}
