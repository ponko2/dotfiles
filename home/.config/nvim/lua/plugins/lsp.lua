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
      vim.lsp.config('eslint', {
        root_dir = (function(root_dir)
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
        'eslint',
        'lua_ls',
        'nixd',
        'oxfmt',
        'oxlint',
        'ruff',
        'stylua',
        'ts_ls',
        'ty',
        'vue_ls',
      })
    end,
  },
}
