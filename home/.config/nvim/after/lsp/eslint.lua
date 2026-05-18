local fs = require('ponko2.fs')

-- refs: https://github.com/neovim/nvim-lspconfig/blob/v2.9.0/lsp/eslint.lua#L114-L152
local root_dir = require('ponko2.lsp').get_lspconfig('eslint').root_dir or function(_, _) end

---@type vim.lsp.Config
return {
  root_dir = function(bufnr, on_dir)
    root_dir(bufnr, function(root)
      if vim.fn.executable(fs.resolve_node_cmd('eslint', root)) == 1 then
        on_dir(root)
      end
    end)
  end,
}
