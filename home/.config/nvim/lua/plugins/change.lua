return {
  {
    'Wansmer/treesj',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
    },
    keys = { '<Leader>j', '<Leader>m', '<Leader>s' },
    config = true,
  },
  {
    'linrongbin16/gitlinker.nvim',
    cmd = 'GitLink',
    keys = {
      { '<Leader>gy', '<Cmd>GitLink<CR>', mode = { 'n', 'v' }, desc = 'Yank git link' },
      { '<Leader>gY', '<Cmd>GitLink!<CR>', mode = { 'n', 'v' }, desc = 'Open git link' },
    },
    config = true,
  },
  {
    'monaqa/dial.nvim',
    keys = {
      { '<C-a>', [[<Plug>(dial-increment)]], mode = { 'n', 'v' } },
      { '<C-x>', [[<Plug>(dial-decrement)]], mode = { 'n', 'v' } },
      { 'g<C-a>', [[g<Plug>(dial-increment)]], mode = { 'n', 'v' } },
      { 'g<C-x>', [[g<Plug>(dial-decrement)]], mode = { 'n', 'v' } },
    },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.new({
            pattern = '%Y年%-m月%-d日（%J）',
            default_kind = 'day',
            only_valid = false,
          }),
          augend.date.alias['%Y年%-m月%-d日(%ja)'],
          augend.date.alias['%Y年%-m月%-d日'],
          augend.date.alias['%Y/%m/%d'],
          augend.date.alias['%Y-%m-%d'],
          augend.date.alias['%m/%d'],
          augend.date.alias['%H:%M'],
          augend.constant.alias.ja_weekday_full,
          augend.constant.new({
            elements = { 'true', 'false' },
            preserve_case = true,
          }),
          augend.case.new({
            types = {
              'camelCase',
              'snake_case',
              'kebab-case',
              'PascalCase',
              'SCREAMING_SNAKE_CASE',
            },
          }),
        },
      })
    end,
  },
}
