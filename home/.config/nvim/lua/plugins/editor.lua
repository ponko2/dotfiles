return {
  {
    'dmtrKovalenko/fff',
    cond = not vim.g.vscode,
    dependencies = 'sainnhe/gruvbox-material',
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
        '<Leader>f/',
        function()
          require('fff').live_grep({
            cwd = vim.fn.expand('%:p:h'),
          })
        end,
        desc = 'Live grep (current directory)',
      },
    },
    opts = {
      hl = {
        cursor = 'FFFCursor',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('custom_highlights_gruvboxmaterial', {}),
        pattern = 'gruvbox-material',
        callback = function()
          ---@type { background: string, foreground: string, colors_override: table<string, [string, string]> }
          local config = vim.fn['gruvbox_material#get_configuration']()
          ---@type { none: [string, string], bg5: [string, string] }
          local palette = vim.fn['gruvbox_material#get_palette'](
            config.background,
            config.foreground,
            config.colors_override
          )
          ---@type fun(group: string, fg: [string, string], bg: [string, string]): nil
          local set_hl = vim.fn['gruvbox_material#highlight']
          set_hl('FFFCursor', palette.none, palette.bg5)
        end,
      })
    end,
  },
  {
    'folke/snacks.nvim',
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    keys = {
      {
        '<Leader>fb',
        function()
          require('snacks').picker.buffers()
        end,
        desc = 'Buffers',
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
