return {
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
    'mikavilpas/yazi.nvim',
    cond = not vim.g.vscode,
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<Leader>fe',
        '<Cmd>Yazi cwd<CR>',
        desc = 'Open yazi in the current working directory',
      },
      {
        '<Leader>f.',
        '<Cmd>Yazi<CR>',
        mode = { 'n', 'v' },
        desc = 'Open yazi at the current file',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      keymaps = {
        show_help = '<F1>',
      },
      open_for_directories = true,
    },
    init = function()
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ghq.nvim',
    },
    keys = {
      { '<Leader>ff', [[<Cmd>Telescope find_files<CR>]], desc = 'Find files' },
      { '<Leader>fg', [[<Cmd>Telescope live_grep<CR>]], desc = 'Live grep' },
      { '<Leader>fb', [[<Cmd>Telescope buffers<CR>]], desc = 'Buffers' },
      { '<Leader>fh', [[<Cmd>Telescope help_tags<CR>]], desc = 'Help tags' },
      { '<Leader>fr', [[<Cmd>Telescope ghq<CR>]], desc = 'Find repositories' },
      {
        '<Leader>f/',
        function()
          require('telescope.builtin').live_grep({
            cwd = vim.fn.expand('%:p:h'),
          })
        end,
        desc = 'Live grep (current directory)',
      },
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
}
