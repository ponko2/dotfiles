return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre', 'VeryLazy' },
    build = ":lua require('nvim-treesitter').update():wait(300000)",
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'css',
          'go',
          'html',
          'javascript',
          'json',
          'lua',
          'markdown',
          'python',
          'scss',
          'toml',
          'typescript',
          'vim',
          'vue',
        },
        callback = function()
          -- syntax highlighting, provided by Neovim
          vim.treesitter.start()
          -- folds, provided by Neovim
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- indentation, provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
