---@type vim.lsp.Config
return {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
  },
  init_options = {
    plugins = {
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
      },
    },
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
