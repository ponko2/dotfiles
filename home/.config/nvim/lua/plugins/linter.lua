return {
  {
    'mfussenegger/nvim-lint',
    cond = not vim.g.vscode,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')
      local patcher = require('ponko2.lint.patcher')
      lint.linters.mypy = patcher.apply_for_venv(lint.linters.mypy)
      lint.linters.textlint = require('ponko2.lint.linters.textlint')
      lint.linters_by_ft = {
        go = { 'golangcilint' },
        lua = { 'luacheck' },
        markdown = { 'textlint' },
        python = { 'mypy' },
        text = { 'textlint' },
      }
      vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
        group = vim.api.nvim_create_augroup('my.linter', {}),
        ---@param ev { buf: integer }
        callback = function(ev)
          lint.try_lint(vim.tbl_filter(function(name) ---@param name string
            local linter = lint.linters[name]
            if not linter then
              return false
            end
            if type(linter) == 'function' then
              linter = linter()
            end
            local cmd = type(linter.cmd) == 'function' and linter.cmd() or linter.cmd
            return vim.fn.executable(cmd) == 1
          end, lint.linters_by_ft[vim.bo[ev.buf].filetype] or {}))
        end,
      })
    end,
  },
}
