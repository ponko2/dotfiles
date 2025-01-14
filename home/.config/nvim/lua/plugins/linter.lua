return {
  {
    'dense-analysis/ale',
    cond = not vim.g.vscode,
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    init = function()
      vim.g.ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'
      vim.g.ale_fixers = {
        css = { 'biome', 'prettier' },
        javascript = { 'biome', 'eslint', 'prettier' },
        javascriptreact = { 'biome', 'eslint', 'prettier' },
        lua = { 'stylua' },
        markdown = { 'textlint' },
        python = { 'ruff_format', 'ruff' },
        text = { 'textlint' },
        typescript = { 'biome', 'eslint', 'prettier' },
        typescriptreact = { 'biome', 'eslint', 'prettier' },
      }
      vim.g.ale_fix_on_save = 1
      vim.g.ale_linters = {
        go = { 'golangci-lint' },
        javascript = { 'biome', 'eslint' },
        javascriptreact = { 'biome', 'eslint' },
        lua = { 'luacheck' },
        markdown = { 'textlint' },
        python = { 'ruff' },
        text = { 'textlint' },
        typescript = { 'biome', 'eslint' },
        typescriptreact = { 'biome', 'eslint' },
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
