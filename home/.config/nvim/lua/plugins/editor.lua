return {
  {
    'folke/snacks.nvim',
    cond = not vim.g.vscode,
    keys = {
      {
        '<Leader>fb',
        function()
          require('snacks').picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<Leader>ff',
        function()
          require('snacks').picker.files()
        end,
        desc = 'Find files',
      },
      {
        '<Leader>fg',
        function()
          require('snacks').picker.grep()
        end,
        desc = 'Live grep',
      },
      {
        '<Leader>fh',
        function()
          require('snacks').picker.help()
        end,
        desc = 'Help tags',
      },
      {
        '<Leader>fr',
        function()
          require('snacks').picker.pick({
            title = 'Find repositories',
            finder = 'proc',
            cmd = 'ghq',
            args = { 'list', '--full-path' },
            format = 'text',
            ---@param item snacks.picker.finder.Item
            transform = function(item)
              item.dir = true
              item.file = item.text
            end,
            confirm = { 'tcd', 'close' },
          })
        end,
        desc = 'Find repositories',
      },
      {
        '<Leader>f/',
        function()
          require('snacks').picker.grep({
            cwd = vim.fn.expand('%:p:h'),
          })
        end,
        desc = 'Live grep (current directory)',
      },
    },
    ---@type snacks.Config
    opts = {
      picker = {
        formatters = {
          file = {
            filename_first = true,
          },
        },
        layout = {
          preset = 'telescope',
        },
        sources = {
          files = {
            hidden = true,
            ---@class snacks.picker.matcher.Config
            matcher = {
              cwd_bonus = true,
              frecency = true,
            },
          },
          grep = {
            hidden = true,
            ---@class snacks.picker.matcher.Config
            matcher = {
              cwd_bonus = true,
              frecency = true,
            },
          },
        },
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
}
