return {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = '/opt/homebrew/opt/vue-language-server/libexec/lib/'
          .. 'node_modules/@vue/language-server/'
          .. 'node_modules/@vue/typescript-plugin',
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
