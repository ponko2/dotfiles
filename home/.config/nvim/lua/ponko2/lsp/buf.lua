local M = {}

---@param clients vim.lsp.Client[]
---@param method vim.lsp.protocol.Method.ClientToServer.Request
---@param params? table|(fun(client: vim.lsp.Client, bufnr: integer): table?)
---@param timeout_ms? integer
---@return table<integer, {err: lsp.ResponseError?, result: any}>?
---@return string?
local function clients_request_sync(clients, method, params, bufnr, timeout_ms)
  local client_request_ids = {} ---@type table<integer,integer>
  local remaining = #clients
  local responses = {} ---@type table<integer, {err: lsp.ResponseError?, result: any}>

  for _, client in ipairs(clients) do
    local cparams = type(params) == 'function' and params(client, bufnr) or params --[[@as table?]]
    local request_success, request_id = client:request(
      method,
      cparams,
      function(err, result, context)
        responses[context.client_id] = { err = err, result = result }
        remaining = remaining - 1
      end,
      bufnr
    )
    if request_success then
      client_request_ids[client.id] = request_id
    end
  end

  local wait_result, reason = vim.wait(timeout_ms or 1000, function()
    return remaining == 0
  end, 10)

  if not wait_result then
    for client_id, request_id in pairs(client_request_ids) do
      local client = vim.lsp.get_client_by_id(client_id)
      if client and client.requests[request_id] then
        client:cancel_request(request_id)
      end
    end
    return nil, ({ [-1] = 'timeout', [-2] = 'interrupted', [-3] = 'error' })[reason]
  end

  return responses
end

---@class ponko2.lsp.buf.apply_code_action.Opts
---@field bufnr integer
---@field kind string
---@field timeout_ms? integer
---@field triggerKind? integer

---@param opts ponko2.lsp.buf.apply_code_action.Opts
---@see https://github.com/neovim/neovim/issues/25259
---@see https://github.com/neovim/neovim/issues/31176
---@see https://github.com/neovim/neovim/blob/v0.12.2/runtime/lua/vim/lsp/buf.lua#L1345-L1419
function M.apply_code_action(opts)
  vim.validate('opts', opts, 'table')
  vim.validate('opts.bufnr', opts.bufnr, 'number')
  vim.validate('opts.kind', opts.kind, 'string')
  vim.validate('opts.timeout_ms', opts.timeout_ms, 'number', true)
  vim.validate('opts.triggerKind', opts.triggerKind, 'number', true)

  local bufnr = vim._resolve_bufnr(opts.bufnr)

  ---@param kind string
  ---@return boolean
  local function matches_requested(kind)
    return kind == opts.kind or vim.startswith(kind, opts.kind .. '.')
  end

  ---@param action lsp.Command|lsp.CodeAction
  ---@param client vim.lsp.Client
  ---@see https://github.com/neovim/neovim/blob/v0.12.2/runtime/lua/vim/lsp/buf.lua#L1247-L1260
  local function apply(action, client)
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
    end
    if action.command then
      local command = type(action.command) == 'table' and action.command or action ---@cast command lsp.Command
      client:exec_cmd(command, { bufnr = bufnr })
    end
  end

  ---@type vim.lsp.Client[]
  local clients = vim
    .iter(vim.lsp.get_clients({ bufnr = bufnr, method = 'textDocument/codeAction' }))
    :filter(function(client) ---@param client vim.lsp.Client
      local provider = client.server_capabilities.codeActionProvider
      if type(provider) ~= 'table' or not provider.codeActionKinds then
        return true
      end
      return vim.iter(provider.codeActionKinds):any(matches_requested)
    end)
    :totable()
  if #clients == 0 then
    return
  end

  local timeout_ms = opts.timeout_ms or 1000
  local win = vim.api.nvim_get_current_win()

  ---@type table<integer, {err: lsp.ResponseError?, result: (lsp.Command|lsp.CodeAction)[]?}>?, string?
  local responses, requests_fail_reason = clients_request_sync(
    clients,
    'textDocument/codeAction',
    function(client)
      local params = vim.lsp.util.make_range_params(win, client.offset_encoding) ---@type lsp.CodeActionParams
      params.context = {
        diagnostics = {},
        only = { opts.kind },
        triggerKind = opts.triggerKind or vim.lsp.protocol.CodeActionTriggerKind.Invoked,
      }
      return params
    end,
    bufnr,
    timeout_ms
  )
  if not responses then
    vim.notify(requests_fail_reason, vim.log.levels.ERROR)
    return
  end

  vim.iter(clients):each(function(client) ---@param client vim.lsp.Client
    local response = responses[client.id]
    if not response then
      return
    end
    if response.err then
      vim.notify(('%s: %s'):format(response.err.code, response.err.message), vim.log.levels.ERROR)
      return
    end

    ---@param action lsp.Command|lsp.CodeAction
    vim.iter(response.result or {}):each(function(action)
      if action.disabled or not action.kind or not matches_requested(action.kind) then
        return
      end
      if type(action.title) == 'string' and type(action.command) == 'string' then
        apply(action, client)
        return
      end
      if (action.edit and action.command) or not client:supports_method('codeAction/resolve') then
        apply(action, client)
        return
      end
      ---@type {err: lsp.ResponseError?, result: (lsp.Command|lsp.CodeAction)?}?, string?
      local resolved, resolve_fail_reason =
        client:request_sync('codeAction/resolve', action, timeout_ms, bufnr)
      if not resolved then
        vim.notify(('%s: %s'):format(client.name, resolve_fail_reason), vim.log.levels.ERROR)
        return
      end
      if resolved.err then
        if action.edit or action.command then
          apply(action, client)
          return
        end
        vim.notify(('%s: %s'):format(resolved.err.code, resolved.err.message), vim.log.levels.ERROR)
        return
      end
      apply(resolved.result, client)
    end)
  end)
end

return M
