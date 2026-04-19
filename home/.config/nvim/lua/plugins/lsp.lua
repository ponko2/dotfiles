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
        'basedpyright',
        'lua_ls',
        'nixd',
        'stylua',
        'ts_ls',
        'vue_ls',
      })
    end,
  },
}
