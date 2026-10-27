local bit = require('bit')

local META = 0x83
local MARKER = 0xA2
local POUND = 0x84
local LAST_NORMAL_TOK = 0x9C
local SNULL = 0x9D
local NULARG = 0xA1

---@param byte integer
---@return boolean
local function is_meta(byte)
  return byte == 0
    or byte == META
    or byte == MARKER
    or (POUND <= byte and byte <= LAST_NORMAL_TOK)
    or (SNULL <= byte and byte <= NULARG)
end

---@param data string
---@return string
local function unmetafy(data)
  ---@type string[]
  local result = {}
  local skipped = false
  local max_index = #data
  for index = 1, max_index do
    local byte = data:byte(index)
    if byte == META then
      skipped = true
    else
      if skipped then
        byte = bit.bxor(byte, 0x20)
      end
      result[#result + 1] = string.char(byte)
      skipped = false
    end
  end
  return table.concat(result)
end

---@param data string
---@return string
local function metafy(data)
  ---@type string[]
  local result = {}
  local max_index = #data
  for index = 1, max_index do
    local byte = data:byte(index)
    if is_meta(byte) then
      result[#result + 1] = string.char(META)
      result[#result + 1] = string.char(bit.bxor(byte, 0x20))
    else
      result[#result + 1] = string.char(byte)
    end
  end
  return table.concat(result)
end

local M = {}

---@param buf integer
function M.read(buf)
  local file = assert(io.open(vim.api.nvim_buf_get_name(buf), 'rb'))
  local data = file:read('*all')
  file:close()
  local lines = vim.split(unmetafy(data):gsub('\n$', ''), '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_set_option_value('modified', false, { buf = buf })
end

---@param buf integer
function M.write(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local data = metafy(table.concat(lines, '\n')) .. '\n'
  local file = assert(io.open(vim.api.nvim_buf_get_name(buf), 'wb'))
  file:write(data)
  file:close()
  vim.api.nvim_set_option_value('modified', false, { buf = buf })
end

return M
