return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_visual = 'reverse'
    end,
    config = function()
      vim.opt.background = 'dark'
      vim.cmd.colorscheme('gruvbox-material')
    end,
  },
  {
    'uga-rosa/ccc.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },
}
