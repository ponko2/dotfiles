return {
  {
    'stevearc/conform.nvim',
    cond = not vim.g.vscode,
    cmd = 'ConformInfo',
    event = 'BufWritePre',
    ---@param opts conform.setupOpts
    config = function(_, opts)
      local buf = require('ponko2.lsp.buf')
      local conform = require('conform')
      conform.setup(opts)
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.formatter', {}),
        pattern = '*',
        ---@param ev { buf: integer }
        callback = function(ev)
          if vim.bo[ev.buf].buftype ~= '' then
            return
          end
          ---@type string[]
          local kinds = vim.tbl_get(
            vim.g,
            'project_settings',
            'filetypes',
            vim.bo[ev.buf].filetype,
            'code_actions_on_save'
          ) or { 'source.fixAll', 'source.organizeImports' }
          for _, kind in ipairs(kinds) do
            buf.apply_code_action({
              bufnr = ev.buf,
              kind = kind,
              timeout_ms = 3000,
              triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Automatic,
            })
          end
          conform.format({
            bufnr = ev.buf,
            timeout_ms = 3000,
          })
        end,
      })
    end,
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      opts.default_format_opts = {
        lsp_format = 'fallback',
      }
      opts.formatters = {
        textlint = require('ponko2.conform.formatters.textlint'),
      }
      opts.formatters_by_ft = {
        css = { 'prettier' },
        javascript = { 'prettier', name = 'oxfmt' },
        javascriptreact = { 'prettier', name = 'oxfmt' },
        lua = { name = 'stylua' },
        markdown = { 'textlint', lsp_format = 'never' },
        text = { 'textlint', lsp_format = 'never' },
        typescript = { 'prettier', name = 'oxfmt' },
        typescriptreact = { 'prettier', name = 'oxfmt' },
        vue = { 'prettier', name = 'oxfmt' },
      }
    end,
  },
}
