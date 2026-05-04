return {
  ---@type lspconfig.settings.rust_analyzer
  settings = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
    },
  },
}
