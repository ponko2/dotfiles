---@type vim.lsp.Config
return {
  ---@type lspconfig.settings.nixd
  settings = {
    nixd = {
      nixpkgs = {
        expr = 'import <nixpkgs> { }',
      },
      formatting = {
        command = { 'nixfmt' },
      },
    },
  },
}
