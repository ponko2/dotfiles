return {
  {
    'vim-jp/vimdoc-ja',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[set helplang& helplang=ja,en]])
    end,
  },
}
