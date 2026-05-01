return {
  {
    'stevearc/conform.nvim',
    cond = not vim.g.vscode,
    cmd = 'ConformInfo',
    event = 'BufWritePre',
    opts = function(_, opts)
      local util = require('conform.util')
      opts.format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 3000,
      }
      opts.formatters = {
        textlint = {
          command = util.from_node_modules('textlint'),
          args = {
            '--fix',
            '--dry-run',
            '--stdin',
            '--stdin-filename',
            '$FILENAME',
            '--format',
            'fixed-result',
          },
          cwd = util.root_file({
            -- refs: https://textlint.github.io/docs/configuring.html
            '.textlintrc',
            '.textlintrc.js',
            '.textlintrc.json',
            '.textlintrc.yml',
            '.textlintrc.yaml',
          }),
          require_cwd = true,
        },
      }
      opts.formatters_by_ft = {
        css = { 'prettier' },
        javascript = { 'prettier' },
        javascriptreact = { 'prettier' },
        markdown = { 'textlint' },
        text = { 'textlint' },
        typescript = { 'prettier' },
        typescriptreact = { 'prettier' },
        vue = { 'prettier' },
      }
    end,
  },
}
