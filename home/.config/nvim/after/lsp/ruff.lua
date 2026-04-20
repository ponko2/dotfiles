local util = require 'lsp.util'

return {
  cmd = function(dispatchers, config)
    local cmd = 'ruff'
    if (config or {}).root_dir then
      local venv_root = vim.fs.root(config.root_dir, '.venv')
      if venv_root then
        local local_cmd = vim.fs.joinpath(venv_root, '.venv/bin', cmd)
        if vim.fn.executable(local_cmd) == 1 then
          cmd = local_cmd
        end
      end
    end
    return vim.lsp.rpc.start({ cmd, 'server' }, dispatchers)
  end,
  root_dir = function(bufnr, on_dir)
    --- Each marker is tried depth-first (all ancestors before next marker),
    --- matching the behavior of `root_markers` in vim.lsp.start().
    --- @see https://github.com/neovim/neovim/blob/b877aa3/runtime/lua/vim/lsp.lua#L726-L732
    local root_markers = {
      '.ruff.toml',
      'ruff.toml',
      util.file_contains_any({ 'pyproject.toml' }, { 'ruff' }),
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
