local M = {}

--- Returns a predicate for vim.fs.root() that matches a directory containing
--- any of `names` with at least one of `patterns` in its content.
---@param names string[]
---@param patterns string[]
---@return fun(name: string, path: string): boolean
function M.file_contains_any(names, patterns)
  local name_set = {} ---@type table<string, true>
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

--- Resolves cmd to a local binary path under bin_dir if available,
--- otherwise falls back to the global command name.
---@param cmd string command name
---@param bin_dir string relative path to the bin directory
---@param source string? path to search from
---@return string
local function resolve_cmd(cmd, bin_dir, source)
  if not source then
    return cmd
  end
  local bin_path = vim.fs.joinpath(vim.fs.normalize(bin_dir), cmd)
  local root_dir = vim.fs.root(source, function(name, path)
    return vim.startswith(bin_path, name .. '/')
      and vim.uv.fs_access(vim.fs.joinpath(path, bin_path), 'X')
  end)
  return root_dir and vim.fs.joinpath(root_dir, bin_path) or cmd
end

--- Returns the resolved command path under node_modules/.bin if available,
--- otherwise falls back to the global command name.
---@param cmd string command name
---@param source string? path to search from
---@return string
function M.resolve_node_cmd(cmd, source)
  return resolve_cmd(cmd, 'node_modules/.bin', source)
end

--- Returns the resolved command path under .venv/bin if available,
--- otherwise falls back to the global command name.
---@param cmd string command name
---@param source string? path to search from
---@return string
function M.resolve_venv_cmd(cmd, source)
  return resolve_cmd(cmd, '.venv/bin', source)
end

return M
