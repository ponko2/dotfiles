--------------------------------------------------------------------------------
-- Autocmds:
--------------------------------------------------------------------------------

-- Create augroup
local id = vim.api.nvim_create_augroup('MyAutoCmd', { clear = true })

-- ファイルの変更を検知してバッファを再読み込み
vim.api.nvim_create_autocmd({ 'FocusGained', 'WinEnter', 'CursorHold', 'CursorHoldI' }, {
  group = id,
  pattern = '*',
  command = [[if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif]],
})
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = id,
  pattern = '*',
  callback = function()
    vim.api.nvim_echo({ { 'File changed on disk. Buffer reloaded.', 'WarningMsg' } }, true, {})
  end,
})

-- quickfixウィンドウを自動で開く
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  group = id,
  pattern = { 'make', 'grep', 'grepadd', 'vimgrep' },
  command = [[tab cwindow]],
})

-- Disable paste.
vim.api.nvim_create_autocmd('InsertLeave', {
  group = id,
  pattern = '*',
  command = [[if &paste | setlocal nopaste | echo 'nopaste' | endif | if &l:diff | diffupdate | endif]],
})

-- Update diff.
vim.api.nvim_create_autocmd('InsertLeave', {
  group = id,
  pattern = '*',
  command = [[if &l:diff | diffupdate | endif]],
})

-- Make directory automatically.
vim.api.nvim_create_autocmd('BufWritePre', {
  group = id,
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if
      vim.fn.isdirectory(dir) == 0
      and vim.opt_local.buftype:get() == ''
      and (
        vim.v.cmdbang == 1
        or vim
          .regex([[\c^y\%[es]$]])
          :match_str(vim.fn.input(('"%s" does not exist. Create? [y/N]: '):format(dir)))
      )
    then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- コメントの自動挿入をしない
vim.api.nvim_create_autocmd({ 'FileType', 'Syntax', 'BufEnter', 'BufWinEnter' }, {
  group = id,
  pattern = '*',
  command = [[setlocal formatoptions-=r formatoptions-=o formatoptions+=mM]],
})

-- promptバッファでは組み込み補完を無効化
vim.api.nvim_create_autocmd('OptionSet', {
  group = id,
  pattern = 'buftype',
  callback = function()
    if vim.v.option_new == 'prompt' then
      vim.opt_local.autocomplete = false
    end
  end,
})

-- LSP
-- refs: https://neovim.io/doc/user/lsp/#lsp-attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    if client:supports_method('textDocument/codeAction') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          ---@param action lsp.Command|lsp.CodeAction
          ---@see https://github.com/neovim/neovim/blob/v0.12.2/runtime/lua/vim/lsp/buf.lua#L1247-L1260
          local function apply_action(action)
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
            end
            local a_cmd = action.command
            if a_cmd then
              local command = type(a_cmd) == 'table' and a_cmd or action
              --- @cast command lsp.Command
              client:exec_cmd(command, { bufnr = ev.buf })
            end
          end
          ---@param kind string
          local function apply_actions(kind)
            local timeout_ms = 1000
            ---@type lsp.CodeActionParams
            local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
            params.context = { only = { kind }, diagnostics = {} }
            local result =
              client:request_sync('textDocument/codeAction', params, timeout_ms, ev.buf)
            ---@type (lsp.Command|lsp.CodeAction)[]
            local actions = result and result.result or {}
            for _, action in ipairs(actions) do
              if
                not (action.edit and action.command)
                and client:supports_method('codeAction/resolve')
              then
                local resolved, err =
                  client:request_sync('codeAction/resolve', action, timeout_ms, ev.buf)
                if err then
                  vim.notify(err, vim.log.levels.ERROR)
                elseif resolved and resolved.err then
                  if action.edit or action.command then
                    apply_action(action)
                  else
                    vim.notify(
                      resolved.err.code .. ': ' .. resolved.err.message,
                      vim.log.levels.ERROR
                    )
                  end
                elseif resolved and resolved.result then
                  apply_action(resolved.result)
                end
              else
                apply_action(action)
              end
            end
          end
          for _, kind in ipairs({ 'source.fixAll', 'source.organizeImports' }) do
            apply_actions(kind)
          end
        end,
      })
    end

    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      local chars = {}
      for i = 33, 126 do
        table.insert(chars, string.char(i))
      end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set(
        'n',
        'gd',
        vim.lsp.buf.definition,
        { buffer = ev.buf, desc = 'vim.lsp.buf.definition()' }
      )
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if
      not client:supports_method('textDocument/willSaveWaitUntil')
      and client:supports_method('textDocument/formatting')
    then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
