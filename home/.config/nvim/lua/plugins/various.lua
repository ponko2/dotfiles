return {
  {
    'numToStr/Comment.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
          enable_autocmd = false,
        },
      },
    },
    event = 'VeryLazy',
    keys = {
      { 'gb', mode = { 'n', 'x' } },
      { 'gbc', mode = 'n' },
      { 'gc', mode = { 'n', 'x' } },
      { 'gcc', mode = 'n' },
    },
    ---@param opts CommentConfig
    opts = function(_, opts)
      opts.pre_hook =
        require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    end,
  },
}
