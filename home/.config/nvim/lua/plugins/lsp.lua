local fs = require('ponko2.fs')

return {
  {
    'j-hui/fidget.nvim',
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    cond = not vim.g.vscode,
    config = function()
      -- refs: https://github.com/neovim/nvim-lspconfig/blob/v2.9.0/lsp/eslint.lua#L114-L152
      vim.lsp.config('eslint', {
        root_dir = (function(root_dir)
          ---@type fun(bufnr: integer, on_dir: fun(root_dir?: string))
          return function(bufnr, on_dir)
            root_dir(bufnr, function(root)
              if vim.fn.executable(fs.resolve_node_cmd('eslint', root)) == 1 then
                on_dir(root)
              end
            end)
          end
        end)(vim.lsp.config.eslint.root_dir),
      })
      vim.lsp.enable({
        'copilot',
        'eslint',
        'lua_ls',
        'nixd',
        'oxfmt',
        'oxlint',
        'ruff',
        'rust_analyzer',
        'stylua',
        'ts_ls',
        'ty',
        'vue_ls',
      })
      vim.lsp.on_type_formatting.enable()
    end,
  },
}
