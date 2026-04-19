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
      vim.lsp.enable({
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
