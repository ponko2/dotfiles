local M = {}

--- Returns a predicate for vim.fs.root() that matches a directory containing
--- any of `names` with at least one of `patterns` in its content.
--- @param names string[]
--- @param patterns string[]
--- @return fun(name: string, path: string): boolean
function M.file_contains_any(names, patterns)
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

return M
