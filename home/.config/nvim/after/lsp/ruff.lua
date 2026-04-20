return {
  cmd = function(dispatchers, config)
    local bin = 'ruff'
    local cmd = { bin }
    if (config or {}).root_dir then
      local local_bin = vim.fs.joinpath(config.root_dir, '.venv/bin', bin)
      if vim.fn.executable(local_bin) == 1 then
        if vim.fn.executable('uv') == 1 then
          cmd = { 'uv', 'run', bin }
        else
          cmd = { local_bin }
        end
      end
    end
    cmd[#cmd + 1] = 'server'
    return vim.lsp.rpc.start(cmd, dispatchers)
  end,
}
