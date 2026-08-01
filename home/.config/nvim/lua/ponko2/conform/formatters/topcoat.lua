local util = require('conform.util')

---@type conform.FormatterConfigOverride
return {
  command = 'topcoat',
  args = { 'fmt', '--stdin' },
  cwd = function(self, ctx)
    return util.root_file({ 'Topcoat.toml' })(self, ctx)
  end,
  require_cwd = true,
}
