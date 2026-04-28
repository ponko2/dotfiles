return {
  {
    'dense-analysis/ale',
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    init = function()
      vim.g.ale_disable_lsp = 1
      vim.g.ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'
      vim.g.ale_fixers = {
        css = { 'prettier' },
        javascript = { 'eslint', 'prettier' },
        javascriptreact = { 'eslint', 'prettier' },
        markdown = { 'textlint' },
        text = { 'textlint' },
        typescript = { 'eslint', 'prettier' },
        typescriptreact = { 'eslint', 'prettier' },
      }
      vim.g.ale_fix_on_save = 1
      vim.g.ale_linters = {
        go = { 'golangci-lint' },
        javascript = { 'eslint' },
        javascriptreact = { 'eslint' },
        lua = { 'luacheck' },
        markdown = { 'textlint' },
        text = { 'textlint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
      }
      vim.g.ale_linters_explicit = 1
      vim.g.ale_sign_column_always = 1
      vim.g.ale_use_neovim_diagnostics_api = 1

      -- Go
      vim.g.ale_go_golangci_lint_options = ''
      vim.g.ale_go_golangci_lint_package = 1
    end,
  },
}
