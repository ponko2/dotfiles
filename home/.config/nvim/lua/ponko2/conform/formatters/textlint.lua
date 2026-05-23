local util = require('conform.util')

---@type conform.FormatterConfigOverride
return {
  command = util.from_node_modules('textlint'),
  args = {
    '--fix',
    '--dry-run',
    '--stdin',
    '--stdin-filename',
    '$FILENAME',
    '--format',
    'fixed-result',
  },
  cwd = util.root_file({
    -- refs: https://textlint.github.io/docs/configuring.html
    '.textlintrc',
    '.textlintrc.js',
    '.textlintrc.json',
    '.textlintrc.yml',
    '.textlintrc.yaml',
  }),
  require_cwd = true,
}
