return {
  {
    'sainnhe/gruvbox-material',
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_visual = 'reverse'
    end,
    config = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  {
    'uga-rosa/ccc.nvim',
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },
}
