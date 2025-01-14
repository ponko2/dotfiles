return {
  {
    'folke/which-key.nvim',
    cond = not vim.g.vscode,
    event = 'VeryLazy',
    keys = {
      {
        '<Leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts = {
      triggers = {
        { '<Leader>', mode = { 'n', 'v' } },
      },
    },
  },
}
