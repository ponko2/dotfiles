return {
  {
    'dmtrKovalenko/fff.nvim',
    cond = not vim.g.vscode,
    build = function()
      require('fff.download').download_or_build_binary()
    end,
    lazy = false,
    keys = {
      {
        '<Leader>ff',
        function()
          require('fff').find_files()
        end,
        desc = 'Find files',
      },
      {
        '<Leader>fg',
        function()
          require('fff').live_grep()
        end,
        desc = 'Live grep',
      },
      {
        '<Leader>f.',
        function()
          require('fff').find_files({
            cwd = vim.fn.expand('%:p:h'),
          })
        end,
        desc = 'Find files (current directory)',
      },
      {
        '<Leader>f/',
        function()
          require('fff').live_grep({
            cwd = vim.fn.expand('%:p:h'),
          })
        end,
        desc = 'Live grep (current directory)',
      },
    },
  },
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', [[<Plug>(EasyAlign)]], mode = { 'n', 'x' } },
    },
  },
  {
    'mattn/emmet-vim',
    event = 'InsertEnter',
    init = function()
      vim.g.user_emmet_settings = { variables = { lang = 'ja' } }
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    cmd = 'Neotree',
    keys = {
      { '<Leader>fe', [[<Cmd>Neotree toggle reveal<CR>]], desc = 'Toggle file browser' },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          never_show = { '.git' },
        },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ghq.nvim',
    },
    keys = {
      { '<Leader>fb', [[<Cmd>Telescope buffers<CR>]], desc = 'Buffers' },
      { '<Leader>fh', [[<Cmd>Telescope help_tags<CR>]], desc = 'Help tags' },
      { '<Leader>fr', [[<Cmd>Telescope ghq<CR>]], desc = 'Find repositories' },
    },
    opts = {
      defaults = {
        path_display = {
          'filename_first',
        },
      },
    },
    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('ghq')
    end,
  },
  {
    'stevearc/oil.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'echasnovski/mini.icons',
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
  },
}
