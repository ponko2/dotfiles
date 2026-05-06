--------------------------------------------------------------------------------
-- Commands:
--------------------------------------------------------------------------------

---@param msg string Content of the notification to show to the user.
---@param level integer|nil One of the values from |vim.log.levels|.
local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO)
end

--- @param cmd string[] Command to execute
--- @param opts? { cwd?: string, on_exit?: fun(out: vim.SystemCompleted) }
--- @return vim.SystemObj
local function run_cmd(cmd, opts)
  opts = opts or {}
  return vim.system(
    cmd,
    { cwd = opts.cwd or vim.fn.getcwd(), text = true },
    vim.schedule_wrap(opts.on_exit or function() end)
  )
end

--- Like the yank operator.
---@param value string
local function yank(value)
  vim.cmd([[normal! "_y]])
  vim.fn.setreg('+', value)
  notify(value:gsub('%%', '%%%%'))
end

--- Prefer the visual selection over the command range in visual mode.
---@param opts { line1: integer, line2: integer }
---@return integer, integer
local function get_range(opts)
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '\22' then
    local a, b = vim.fn.line('v'), vim.fn.line('.')
    if a > b then
      return b, a
    end
    return a, b
  end
  return opts.line1, opts.line2
end

-- cd to git root
vim.api.nvim_create_user_command('CdGitRoot', function()
  local result = run_cmd({ 'git', 'rev-parse', '--show-toplevel' }):wait()
  if result.code ~= 0 then
    notify(vim.trim(result.stderr), vim.log.levels.ERROR)
    return
  end
  local root = vim.trim(result.stdout)
  if root == vim.uv.cwd() then
    return
  end
  vim.api.nvim_set_current_dir(root)
  notify(vim.fn.fnamemodify(root, ':~'))
end, {})

-- grep
vim.api.nvim_create_user_command('Grep', function(opts)
  vim.cmd(([[silent grep! "%s"]]):format(vim.fn.escape(opts.args, '"')))
  vim.cmd([[redraw!]])
end, { nargs = '+' })
vim.api.nvim_create_user_command('GrepAdd', function(opts)
  vim.cmd(([[silent grepadd! "%s"]]):format(vim.fn.escape(opts.args, '"')))
  vim.cmd([[redraw!]])
end, { nargs = '+' })

-- Trim trailing whitespace
vim.api.nvim_create_user_command('TrimTrailingWhitespace', function(opts)
  local view = vim.fn.winsaveview()
  vim.cmd(([[keepjumps keeppatterns %d,%ds/[[:space:]　]\+$//e]]):format(opts.line1, opts.line2))
  vim.fn.winrestview(view)
end, { range = '%' })

-- Yank agent context
vim.api.nvim_create_user_command('YankAgentContext', function(opts)
  local path = vim.fn.expand('%:.')
  if path == '' or vim.bo.buftype ~= '' then
    notify('Not a file buffer', vim.log.levels.WARN)
    return
  end
  if opts.bang then
    yank(('@%s'):format(path))
    return
  end
  local line1, line2 = get_range(opts)
  if line1 == line2 then
    yank(('@%s:%d'):format(path, line1))
  else
    yank(('@%s:%d-%d'):format(path, line1, line2))
  end
end, { bang = true, range = true })
