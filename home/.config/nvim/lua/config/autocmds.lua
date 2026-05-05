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
          local buf = require('ponko2.lsp.buf')
          ---@type string[]
          local kinds = vim.tbl_get(
            vim.g,
            'project_settings',
            'filetypes',
            vim.bo[ev.buf].filetype,
            'code_actions_on_save'
          ) or { 'source.fixAll', 'source.organizeImports' }
          for _, kind in ipairs(kinds) do
            buf.code_action({
              diagnostics = {},
              only = { kind },
              triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Automatic,
            })
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

    if client:supports_method('textDocument/inlayHint', ev.buf) then
      vim.keymap.set('n', 'grh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = 'Toggle inlay hints' })
    end

    if client:supports_method('textDocument/inlineCompletion', ev.buf) then
      vim.lsp.inline_completion.enable(true, { bufnr = ev.buf })
      vim.keymap.set('i', '<Tab>', function()
        if vim.lsp.inline_completion.get() then
          if vim.fn.pumvisible() == 1 then
            return '<C-e>'
          end
          return ''
        end
        if vim.fn.pumvisible() == 1 then
          return '<C-n>'
        end
        return '<Tab>'
      end, { buffer = ev.buf, desc = 'Accept inline completion', expr = true })
      vim.keymap.set(
        'i',
        '<A-]>',
        vim.lsp.inline_completion.select,
        { buffer = ev.buf, desc = 'Show next inline completion' }
      )
      vim.keymap.set('i', '<A-[>', function()
        vim.lsp.inline_completion.select({ count = -1 })
      end, { buffer = ev.buf, desc = 'Show previous inline completion' })
    end
  end,
})
