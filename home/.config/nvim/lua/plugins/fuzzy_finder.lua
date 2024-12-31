return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ghq.nvim",
		},
		keys = {
			{ "<Leader>ff", [[<Cmd>Telescope find_files<CR>]], { noremap = true } },
			{ "<Leader>fg", [[<Cmd>Telescope live_grep<CR>]], { noremap = true } },
			{ "<Leader>fb", [[<Cmd>Telescope buffers<CR>]], { noremap = true } },
			{ "<Leader>fh", [[<Cmd>Telescope help_tags<CR>]], { noremap = true } },
			{ "<Leader>fr", [[<Cmd>Telescope ghq<CR>]], { noremap = true } },
			{
				"<Leader>f.",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.fn.expand("%:p:h"),
					})
				end,
				{ noremap = true },
			},
		},
		config = function()
			require("telescope").load_extension("ghq")
		end,
	},
}
