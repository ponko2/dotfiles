--- Returns a predicate for vim.fs.root() that matches a directory containing
--- any of `names` with at least one of `patterns` in its content.
--- @param names string[]
--- @param patterns string[]
--- @return fun(name: string, path: string): boolean
local function file_contains_any(names, patterns)
  local name_set = {} --- @type table<string, true>
  for _, filename in ipairs(names) do
    name_set[filename] = true
  end
  return function(name, path)
    if not name_set[name] then
      return false
    end
    local file = io.open(vim.fs.joinpath(path, name), 'r')
    if not file then
      return false
    end
    local matched = false
    for line in file:lines() do
      if vim.iter(patterns):any(function(pattern)
        return line:find(pattern)
      end) then
        matched = true
        break
      end
    end
    file:close()
    return matched
  end
end

return {
  root_dir = function(bufnr, on_dir)
    --- Each marker is tried depth-first (all ancestors before next marker),
    --- matching the behavior of `root_markers` in vim.lsp.start().
    --- @see https://github.com/neovim/neovim/blob/b877aa3/runtime/lua/vim/lsp.lua#L726-L732
    local root_markers = {
      '.oxfmtrc.json',
      '.oxfmtrc.jsonc',
      'oxfmt.config.ts',
      file_contains_any({ 'vite.config.js', 'vite.config.ts' }, { 'vite%-plus' }),
      file_contains_any({ 'package.json', 'package.json5' }, { 'oxfmt', 'vite%-plus' }),
    }
    for _, marker in ipairs(root_markers) do
      local root = vim.fs.root(bufnr, marker)
      if root then
        on_dir(root)
        return
      end
    end
  end,
}
