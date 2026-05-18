local M = {}

--- Reads the client config directly from nvim-lspconfig.
---@param name string Name of client
---@return vim.lsp.Config
function M.get_lspconfig(name)
  for _, file in ipairs(vim.api.nvim_get_runtime_file(('lsp/%s.lua'):format(name), true)) do
    if file:find('/nvim-lspconfig/', 1, true) then
      local config = assert(loadfile(file))() ---@type any?
      if type(config) == 'table' then
        return config
      else
        error(('%s: not a table'):format(file))
      end
    end
  end
  error(('lsp/%s.lua: not found in nvim-lspconfig'):format(name))
end

return M
