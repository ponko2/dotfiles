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
            location = (function()
              local path = vim.fs.dirname(vim.fn.exepath('vue-language-server'))
                .. '/../lib/language-tools/packages/language-server'
              if vim.loop.fs_stat(path) then
                -- for Nix
                return path
              end
              -- for Homebrew
              return vim.env.HOMEBREW_PREFIX
                .. '/opt/vue-language-server/libexec/lib'
                .. '/node_modules/@vue/language-server'
            end)(),
            languages = { 'vue' },
            configNamespace = 'typescript',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
}
