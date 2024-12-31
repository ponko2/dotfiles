--------------------------------------------------------------------------------
-- Key-mappings:
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Normal mode keymappings:

-- 検索の強調表示を無効化
vim.keymap.set("n", "<C-l>", [[<Cmd>nohlsearch<CR><C-l>]], { noremap = true })

-- 引数リスト移動
vim.keymap.set("n", "[a", [[<Cmd>previous<CR>]], { noremap = true })
vim.keymap.set("n", "]a", [[<Cmd>next<CR>]], { noremap = true })
vim.keymap.set("n", "[A", [[<Cmd>first<CR>]], { noremap = true })
vim.keymap.set("n", "]A", [[<Cmd>last<CR>]], { noremap = true })

-- バッファリスト移動
vim.keymap.set("n", "[b", [[<Cmd>bprevious<CR>]], { noremap = true })
vim.keymap.set("n", "]b", [[<Cmd>bnext<CR>]], { noremap = true })
vim.keymap.set("n", "[B", [[<Cmd>bfirst<CR>]], { noremap = true })
vim.keymap.set("n", "]B", [[<Cmd>blast<CR>]], { noremap = true })

-- ロケーションリスト移動
vim.keymap.set("n", "[l", function()
	xpcall(function()
		vim.cmd.lprevious()
	end, function()
		vim.cmd.llast()
	end)
end, { noremap = true })
vim.keymap.set("n", "]l", function()
	xpcall(function()
		vim.cmd.lnext()
	end, function()
		vim.cmd.lfirst()
	end)
end, { noremap = true })
vim.keymap.set("n", "[L", [[<Cmd>lfirst<CR>]], { noremap = true })
vim.keymap.set("n", "]L", [[<Cmd>llast<CR>]], { noremap = true })

-- エラーリスト移動
vim.keymap.set("n", "[q", function()
	xpcall(function()
		vim.cmd.cprevious()
	end, function()
		vim.cmd.clast()
	end)
end, { noremap = true })
vim.keymap.set("n", "]q", function()
	xpcall(function()
		vim.cmd.cnext()
	end, function()
		vim.cmd.cfirst()
	end)
end, { noremap = true })
vim.keymap.set("n", "[Q", [[<Cmd>cfirst<CR>]], { noremap = true })
vim.keymap.set("n", "]Q", [[<Cmd>clast<CR>]], { noremap = true })

-- タグリスト移動
vim.keymap.set("n", "[t", [[<Cmd>tprevious<CR>]], { noremap = true })
vim.keymap.set("n", "]t", [[<Cmd>tnext<CR>]], { noremap = true })
vim.keymap.set("n", "[T", [[<Cmd>tfirst<CR>]], { noremap = true })
vim.keymap.set("n", "]T", [[<Cmd>tlast<CR>]], { noremap = true })

-- Better n
vim.keymap.set("n", "n", [[<Cmd>execute 'normal!' v:count1 .. 'nzvzz'<CR>]], { noremap = true })
vim.keymap.set("n", "N", [[<Cmd>execute 'normal!' v:count1 .. 'Nzvzz'<CR>]], { noremap = true })

-- Better x
vim.keymap.set("n", "x", [["_x]], { noremap = true })

-- Better Y
vim.keymap.set("n", "Y", [[y$]], { noremap = true })

-- grep
vim.keymap.set("n", "<Leader>/", [[:<C-u>Grep<Space>]], { noremap = true })

--------------------------------------------------------------------------------
-- Command-line mode keymappings:

-- Next history.
vim.keymap.set("c", "<Down>", function()
	if vim.fn.pumvisible() == 1 then
		return "<Down>"
	else
		return "<C-n>"
	end
end, { noremap = true, expr = true })
vim.keymap.set("c", "<C-n>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	else
		return "<Down>"
	end
end, { noremap = true, expr = true })

-- Previous history.
vim.keymap.set("c", "<Up>", function()
	if vim.fn.pumvisible() == 1 then
		return "<Up>"
	else
		return "<C-p>"
	end
end, { noremap = true, expr = true })
vim.keymap.set("c", "<C-p>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	else
		return "<Up>"
	end
end, { noremap = true, expr = true })

-- %% -> %:h/
vim.keymap.set("c", "%%", function()
	if vim.fn.getcmdtype() == ":" then
		return vim.fn.expand("%:h") .. "/"
	else
		return "%%"
	end
end, { noremap = true, expr = true })

--------------------------------------------------------------------------------
-- Visual mode keymappings:

-- Disable dos-standard-mappings
vim.cmd([[silent! vunmap <C-x>]])

--------------------------------------------------------------------------------
-- Terminal keymappings:

if vim.fn.exists(":tnoremap") == 2 then
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { noremap = true })
end
