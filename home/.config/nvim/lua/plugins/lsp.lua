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
        'nixd',
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
}
