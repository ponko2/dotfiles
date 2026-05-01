local fs = require('ponko2.fs')

return {
  {
    'j-hui/fidget.nvim',
    cond = not vim.g.vscode,
    event = 'LspAttach',
    opts = {
      progress = {
        ignore = {
          'null-ls',
        },
      },
    },
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
        'copilot',
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
      vim.lsp.on_type_formatting.enable()
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'gbprod/none-ls-luacheck.nvim',
      'nvim-lua/plenary.nvim',
      'nvimtools/none-ls-extras.nvim',
    },
    event = 'LspAttach',
    opts = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = {
        -- Code Actions
        null_ls.builtins.code_actions.textlint.with({
          only_local = 'node_modules/.bin',
        }),
        -- Diagnostics
        null_ls.builtins.diagnostics.golangci_lint,
        require('none-ls-luacheck.diagnostics.luacheck'),
        null_ls.builtins.diagnostics.textlint.with({
          filetypes = { 'markdown', 'text' },
          only_local = 'node_modules/.bin',
        }),
        -- Formatting
        null_ls.builtins.formatting.prettier.with({
          only_local = 'node_modules/.bin',
        }),
        null_ls.builtins.formatting.textlint.with({
          filetypes = { 'markdown', 'text' },
          only_local = 'node_modules/.bin',
        }),
      }
    end,
  },
}
