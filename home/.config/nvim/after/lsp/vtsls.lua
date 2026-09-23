---@type vim.lsp.Config
return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
  },
  ---@type lspconfig.settings.vtsls
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          {
            name = '@vue/typescript-plugin',
            location = vim.fs.joinpath(
              vim.fs.dirname(vim.fn.exepath('vue-language-server')),
              '/../@vue/language-server'
            ),
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
}
