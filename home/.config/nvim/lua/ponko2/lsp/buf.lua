local M = {}

---@param action lsp.Command|lsp.CodeAction
---@param client vim.lsp.Client
---@param context lsp.HandlerContext
local function apply_action(action, client, context)
  if action.edit then
    vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
  end
  local action_command = action.command
  if action_command then
    local command = type(action_command) == 'table' and action_command or action
    ---@cast command lsp.Command
    client:exec_cmd(command, context)
  end
end

---@param action lsp.Command|lsp.CodeAction
---@param context lsp.CodeActionContext
local function action_filter(action, context)
  if context.only then
    if not action.kind then
      return false
    end
    local found = false
    for _, kind in ipairs(context.only) do
      if action.kind == kind or vim.startswith(action.kind, kind .. '.') then
        found = true
        break
      end
    end
    if not found then
      return false
    end
  end
  if action.disabled then
    return false
  end
  return true
end

---@param context lsp.CodeActionContext
---@see https://github.com/neovim/neovim/issues/25259
---@see https://github.com/neovim/neovim/issues/31176
---@see https://github.com/neovim/neovim/blob/v0.12.2/runtime/lua/vim/lsp/buf.lua#L1247-L1260
function M.code_action(context)
  vim.validate('context', context, 'table')

  local timeout_ms = 3000
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  local clients = vim.lsp.get_clients({ bufnr = buf, method = 'textDocument/codeAction' })
  if not next(clients) then
    return
  end

  ---@type table<integer, vim.lsp.CodeActionResultEntry>
  local results = assert(vim.lsp.buf_request_sync(buf, 'textDocument/codeAction', function(client)
    ---@type lsp.CodeActionParams
    local params = vim.lsp.util.make_range_params(win, client.offset_encoding)
    params.context = context
    return params
  end, timeout_ms))

  for _, entry in pairs(results) do
    local client = assert(vim.lsp.get_client_by_id(entry.context.client_id))
    local bufnr = assert(entry.context.bufnr, 'Must have buffer number')
    for _, action in pairs(entry.result or {}) do
      if action_filter(action, context) then
        if type(action.title) == 'string' and type(action.command) == 'string' then
          apply_action(action, client, entry.context)
        elseif
          not (action.edit and action.command)
          and client:supports_method('codeAction/resolve')
        then
          local resolved =
            assert(client:request_sync('codeAction/resolve', action, timeout_ms, bufnr))
          local err, resolved_action = resolved.err, resolved.result
          if err then
            if action.edit or action.command then
              apply_action(action, client, entry.context)
            else
              vim.notify(err.code .. ': ' .. err.message, vim.log.levels.ERROR)
            end
          else
            apply_action(resolved_action, client, entry.context)
          end
        else
          apply_action(action, client, entry.context)
        end
      end
    end
  end
end

return M
