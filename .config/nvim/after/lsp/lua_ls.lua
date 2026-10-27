---@type vim.lsp.Config
return {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        not vim.startswith(vim.uv.fs_realpath(vim.fn.stdpath('config')) or '', path)
        and (
          vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.json'))
          or vim.uv.fs_stat(vim.fs.joinpath(path, '.luarc.jsonc'))
        )
      then
        return
      end
    end
    ---@type lspconfig.settings.lua_ls
    local settings = client.config.settings
    client.config.settings.Lua = vim.tbl_deep_extend('force', settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = vim.list_extend(
          vim
            .iter(vim.api.nvim_get_runtime_file('lua', true))
            :filter(function(path)
              return not vim.startswith(path, vim.fn.stdpath('config'))
            end)
            :totable(),
          {
            '${3rd}/busted/library',
            '${3rd}/luv/library',
          }
        ),
      },
    })
  end,
  ---@type lspconfig.settings.lua_ls
  settings = {
    Lua = {
      -- Disable code lens
      codeLens = {
        enable = false,
      },
      -- Disable the built-in formatter
      format = {
        enable = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
