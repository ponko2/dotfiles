return {
  {
    'kana/vim-operator-replace',
    dependencies = 'kana/vim-operator-user',
    keys = {
      { 'p', [[<Plug>(operator-replace)]], mode = 'x' },
    },
  },
  {
    'kylechui/nvim-surround',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
      },
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
      },
    },
    event = 'VeryLazy',
    config = true,
  },
  {
    'machakann/vim-sandwich',
    event = 'VeryLazy',
    init = function()
      vim.g.operator_sandwich_no_default_key_mappings = 1
    end,
  },
  {
    'rhysd/accelerated-jk',
    keys = {
      { 'j', [[<Plug>(accelerated_jk_gj)]] },
      { 'k', [[<Plug>(accelerated_jk_gk)]] },
    },
  },
}
