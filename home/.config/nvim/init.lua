if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.opt.shellslash = true
end

if vim.fn.filereadable(vim.fn.expand("~/.vimrc_secret")) == 1 then
	vim.cmd.source(vim.fn.expand("~/.vimrc_secret"))
end

-- Use English interface.
vim.cmd.language("message C")

-- <Leader>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<Space>", "<Nop>", { noremap = true })

-- Minimize:
require("config.minimize")

-- Plugins:
require("config.lazy")

-- Options:
require("config.options")

-- Mappings:
require("config.mappings")

-- Commands:
require("config.commands")

vim.opt.secure = true
