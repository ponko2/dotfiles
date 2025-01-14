return {
  {
    'mattn/vim-maketable',
    ft = 'markdown',
  },
  {
    'rhysd/vim-gfm-syntax',
    ft = 'markdown',
    init = function()
      vim.g.markdown_fenced_languages = {
        'diff',
        'javascript',
        'json',
        'python',
        'sh',
        'sql',
        'typescript',
      }
    end,
  },
}
