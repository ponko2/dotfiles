return {
  {
    'apple/pkl-neovim',
    lazy = true,
    ft = 'pkl',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    build = function()
      require('pkl-neovim').init()
    end,
  },
}
