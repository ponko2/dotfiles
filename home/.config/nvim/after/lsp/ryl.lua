---@type vim.lsp.Config
return {
  cmd = { 'ryl', 'server' },
  filetypes = { 'yaml', 'markdown' },
  root_markers = {
    '.ryl.toml',
    'ryl.toml',
    '.yamllint',
    '.yamllint.yml',
    '.yamllint.yaml',
    '.git',
  },
}
