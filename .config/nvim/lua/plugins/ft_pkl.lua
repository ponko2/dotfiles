return {
  {
    'apple/pkl-neovim',
    lazy = true,
    ft = 'pkl',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    build = function()
      require('pkl-neovim').init()
    end,
    config = function()
      vim.g.pkl_neovim = {
        pkl_cli_path = 'pkl',
        start_command = { 'pkl-lsp' },
      }
    end,
  },
}
