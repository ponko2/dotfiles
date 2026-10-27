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
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
    },
    keys = {
      {
        'af',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject(
            '@function.outer',
            'textobjects'
          )
        end,
        mode = { 'x', 'o' },
      },
      {
        'if',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject(
            '@function.inner',
            'textobjects'
          )
        end,
        mode = { 'x', 'o' },
      },
      {
        'ac',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject(
            '@class.outer',
            'textobjects'
          )
        end,
        mode = { 'x', 'o' },
      },
      {
        'ic',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject(
            '@class.inner',
            'textobjects'
          )
        end,
        mode = { 'x', 'o' },
      },
      {
        ']m',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_start(
            '@function.outer',
            'textobjects'
          )
        end,
        mode = { 'n', 'x', 'o' },
      },
      {
        ']]',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
      },
      {
        ']M',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_end(
            '@function.outer',
            'textobjects'
          )
        end,
        mode = { 'n', 'x', 'o' },
      },
      {
        '][',
        function()
          require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
        end,
        mode = { 'n', 'x', 'o' },
      },
      {
        '[m',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_start(
            '@function.outer',
            'textobjects'
          )
        end,
        mode = { 'n', 'x', 'o' },
      },
      {
        '[[',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_start(
            '@class.outer',
            'textobjects'
          )
        end,
        mode = { 'n', 'x', 'o' },
      },
      {
        '[M',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_end(
            '@function.outer',
            'textobjects'
          )
        end,
        mode = { 'n', 'x', 'o' },
      },
      {
        '[]',
        function()
          require('nvim-treesitter-textobjects.move').goto_previous_end(
            '@class.outer',
            'textobjects'
          )
        end,
        mode = { 'n', 'x', 'o' },
      },
    },
    opts = {
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    },
  },
  {
    'rhysd/accelerated-jk',
    keys = {
      { 'j', [[<Plug>(accelerated_jk_gj)]] },
      { 'k', [[<Plug>(accelerated_jk_gk)]] },
    },
  },
}
