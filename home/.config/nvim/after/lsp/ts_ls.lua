return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = (function()
          local path = vim.fs.dirname(vim.fn.exepath('vue-language-server'))
            .. '/../lib/language-tools/packages/typescript-plugin'
          if vim.loop.fs_stat(path) then
            -- for Nix
            return path
          end
          -- for Homebrew
          return vim.env.HOMEBREW_PREFIX
            .. '/opt/vue-language-server/libexec/lib'
            .. '/node_modules/@vue/language-server'
            .. '/node_modules/@vue/typescript-plugin'
        end)(),
        languages = { 'javascript', 'typescript', 'vue' },
      },
    },
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
}
