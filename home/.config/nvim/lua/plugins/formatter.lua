return {
  {
    'stevearc/conform.nvim',
    cond = not vim.g.vscode,
    cmd = 'ConformInfo',
    event = 'BufWritePre',
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      opts.format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 3000,
      }
      opts.formatters = {
        textlint = require('ponko2.conform.formatters.textlint'),
      }
      opts.formatters_by_ft = {
        css = { 'prettier' },
        javascript = { 'prettier', name = 'oxfmt' },
        javascriptreact = { 'prettier', name = 'oxfmt' },
        lua = { name = 'stylua' },
        markdown = { 'textlint' },
        text = { 'textlint' },
        typescript = { 'prettier', name = 'oxfmt' },
        typescriptreact = { 'prettier', name = 'oxfmt' },
        vue = { 'prettier', name = 'oxfmt' },
      }
    end,
  },
}
