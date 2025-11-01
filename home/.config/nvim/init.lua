if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
  vim.opt.shellslash = true
end

if vim.fn.filereadable(vim.fn.expand('~/.vimrc_secret')) == 1 then
  vim.cmd.source(vim.fn.expand('~/.vimrc_secret'))
end

-- Use English interface.
vim.cmd.language('message C')

-- <Leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.keymap.set('n', '<Space>', '<Nop>')

-- Minimize:
require('config.minimize')

-- Options:
require('config.options')

-- Autocmds:
require('config.autocmds')

-- Mappings:
require('config.mappings')

-- Commands:
require('config.commands')

-- Diagnostic:
require('config.diagnostic')

-- Plugins:
require('config.lazy')

vim.opt.secure = true
