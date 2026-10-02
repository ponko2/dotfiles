-- TODO: @vue/language-server が --tsdk なしで起動できるようになったら削除する
-- refs: https://github.com/vuejs/language-tools/pull/6170

---@param root_dir string?
---@return string
local function resolve_tsdk(root_dir)
  local tsdk = 'node_modules/typescript/lib'
  local project = root_dir
    and vim.fs.root(root_dir, function(name, path)
      return name == 'node_modules'
        and vim.uv.fs_stat(vim.fs.joinpath(path, tsdk, 'typescript.js')) ~= nil
    end)
  if project then
    return vim.fs.joinpath(project, tsdk)
  end
  return vim.fs.joinpath(vim.fs.dirname(vim.fn.exepath('vtsls')), '../.mise', tsdk)
end

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start({
      'vue-language-server',
      '--stdio',
      '--tsdk=' .. resolve_tsdk(config.root_dir),
    }, dispatchers)
  end,
}
