local fs = require('ponko2.fs')

--- Converts col and end_col of a vim.Diagnostic from CLI command output positions to byte indices.
--- @param diagnostic vim.Diagnostic
--- @param bufnr integer
--- @return vim.Diagnostic
--- @see https://github.com/neovim/neovim/blob/v0.12.2/runtime/lua/vim/lsp/diagnostic.lua#L88-L131
local function diagnostic_cmd_to_vim(diagnostic, bufnr)
  local position_encoding = 'utf-16'
  local lines = vim.api.nvim_buf_get_lines(bufnr, diagnostic.lnum, diagnostic.end_lnum + 1, false)
  return vim.tbl_extend('force', diagnostic, {
    col = vim.str_byteindex(lines[1] or '', position_encoding, diagnostic.col, false),
    end_col = vim.str_byteindex(lines[#lines] or '', position_encoding, diagnostic.end_col, false),
  })
end

--- Wraps a linter to prefer the local .venv binary, using `uv run -m` if available.
--- @param base_linter lint.Linter
--- @return fun(): lint.Linter
local function with_venv(base_linter)
  return function()
    local cmd = fs.resolve_venv_cmd(base_linter.cmd, vim.api.nvim_buf_get_name(0))
    if cmd == base_linter.cmd then
      return base_linter
    end
    if vim.fn.executable('uv') == 1 then
      return vim.tbl_extend('force', base_linter, {
        cmd = 'uv',
        args = vim.list_extend({ 'run', '-m', base_linter.cmd }, base_linter.args or {}),
      })
    end
    return vim.tbl_extend('force', base_linter, { cmd = cmd })
  end
end

return {
  {
    'mfussenegger/nvim-lint',
    cond = not vim.g.vscode,
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require('lint')
      lint.linters.mypy = with_venv(lint.linters.mypy --[[@as lint.Linter]])
      ---@type lint.Linter | { cmd: fun(): string }
      lint.linters.textlint = {
        name = 'textlint',
        cmd = function()
          return fs.resolve_node_cmd('textlint', vim.api.nvim_buf_get_name(0))
        end,
        args = {
          '--stdin',
          '--stdin-filename',
          function()
            return vim.api.nvim_buf_get_name(0)
          end,
          '--format',
          'json',
        },
        stdin = true,
        stream = 'stdout',
        ignore_exitcode = true,
        parser = function(output, bufnr)
          local trimmed_output = vim.trim(output)
          if trimmed_output == '' then
            return {}
          end
          if string.find(trimmed_output, 'No rules found, textlint hasn’t done anything') then
            vim.notify_once(trimmed_output, vim.log.levels.WARN)
            return {}
          end
          local decode_opts = { luanil = { object = true, array = true } }
          local ok, data = pcall(vim.json.decode, output, decode_opts)
          if not ok then
            ---@type vim.Diagnostic[]
            local diagnostics = {
              {
                bufnr = bufnr,
                lnum = 0,
                end_lnum = 0,
                col = 0,
                end_col = 0,
                severity = vim.diagnostic.severity.ERROR,
                message = 'Could not parse linter output due to: '
                  .. data
                  .. '\noutput: '
                  .. output,
              },
            }
            return diagnostics
          end
          local severities = {
            [0] = vim.diagnostic.severity.INFO,
            [1] = vim.diagnostic.severity.WARN,
            [2] = vim.diagnostic.severity.ERROR,
          }
          ---@type vim.Diagnostic[]
          local diagnostics = {}
          ---@alias Location { start: { line: number, column: number }, ["end"]: { line: number, column: number }}
          ---@alias Message { loc: Location, message: string, ruleId: string, severity: number }
          ---@alias Result { messages?: Message[] }
          ---@type Result[]
          local results = data or {}
          for _, result in ipairs(results) do
            ---@type Message[]
            local messages = result.messages or {}
            for _, message in ipairs(messages) do
              ---@type vim.Diagnostic
              local diagnostic = {
                bufnr = bufnr,
                lnum = message.loc.start.line - 1,
                end_lnum = message.loc['end'].line - 1,
                col = message.loc.start.column - 1,
                end_col = message.loc['end'].column - 1,
                message = message.message,
                code = message.ruleId,
                severity = severities[message.severity],
                source = 'textlint',
              }
              table.insert(diagnostics, diagnostic_cmd_to_vim(diagnostic, bufnr))
            end
          end
          return diagnostics
        end,
      }
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
