return {
  {
    'hrsh7th/cmp-nvim-lsp',
    cond = not vim.g.vscode,
    optional = true,
    dependencies = 'neovim/nvim-lspconfig',
    config = function()
      -- Set up lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- JavaScript/TypeScript
      require('lspconfig')['ts_ls'].setup({
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = '/opt/homebrew/opt/vue-language-server/libexec/lib/'
                .. 'node_modules/@vue/language-server/'
                .. 'node_modules/@vue/typescript-plugin',
              languages = { 'javascript', 'typescript', 'vue' },
            },
          },
        },
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'vue',
        },
      })

      -- Lua
      require('lspconfig')['lua_ls'].setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                'vim',
                'require',
              },
            },
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file('', true),
            },
          },
        },
      })

      -- Python
      require('lspconfig')['basedpyright'].setup({
        capabilities = capabilities,
        settings = {
          basedpyright = {
            typeCheckingMode = 'off',
          },
        },
      })

      -- Vue
      require('lspconfig')['volar'].setup({
        capabilities = capabilities,
      })
    end,
  },
  {
    'j-hui/fidget.nvim',
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = true,
  },
  {
    'nvimdev/lspsaga.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      definition = {
        keys = {
          edit = 'o',
          vsplit = 'v',
          split = 'i',
          tabe = 't',
        },
      },
    },
    config = function(_, opts)
      require('lspsaga').setup(opts)
      vim.opt.signcolumn = 'yes'
      vim.api.nvim_create_autocmd('LspAttach', {
        ---@param ev { buf: integer, data: { client_id: integer } }
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end
          local kopts = { buffer = ev.buf }
          if client.supports_method('textDocument/definition') then
            vim.keymap.set('n', '<F12>', [[<Cmd>Lspsaga peek_definition<CR>]], kopts)
            vim.keymap.set('n', 'gd', [[<Cmd>Lspsaga peek_definition<CR>]], kopts)
          end
          if client.supports_method('textDocument/rename') then
            vim.keymap.set('n', '<F2>', [[<Cmd>Lspsaga rename<CR>]], kopts)
          end
        end,
      })
    end,
  },
}
