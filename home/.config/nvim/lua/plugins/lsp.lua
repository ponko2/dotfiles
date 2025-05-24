return {
  {
    'hrsh7th/cmp-nvim-lsp',
    cond = not vim.g.vscode,
    optional = true,
    dependencies = 'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      vim.lsp.enable({
        'basedpyright',
        'lua_ls',
        'ts_ls',
        'vue_ls',
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
          local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
          local kopts = { buffer = ev.buf }
          if client:supports_method('textDocument/codeAction') then
            vim.keymap.set('n', 'gra', [[<Cmd>Lspsaga code_action<CR>]], kopts)
          end
          if client:supports_method('textDocument/definition') then
            vim.keymap.set('n', '<F12>', [[<Cmd>Lspsaga peek_definition<CR>]], kopts)
            vim.keymap.set('n', 'gd', [[<Cmd>Lspsaga peek_definition<CR>]], kopts)
          end
          if client:supports_method('textDocument/rename') then
            vim.keymap.set('n', '<F2>', [[<Cmd>Lspsaga rename<CR>]], kopts)
            vim.keymap.set('n', 'grn', [[<Cmd>Lspsaga rename<CR>]], kopts)
          end
        end,
      })
    end,
  },
}
