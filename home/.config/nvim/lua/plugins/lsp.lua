return {
  {
    'j-hui/fidget.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = true,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable({
        'eslint',
        'lua_ls',
        'nixd',
        'oxfmt',
        'oxlint',
        'pkl',
        'ruff',
        'rust_analyzer',
        'stylua',
        'ty',
        'vtsls',
        'vue_ls',
      })
      vim.lsp.on_type_formatting.enable()
    end,
  },
}
