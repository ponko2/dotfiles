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
        'copilot',
        'eslint',
        'lua_ls',
        'nixd',
        'oxfmt',
        'oxlint',
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
