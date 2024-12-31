return {
	{
		"rbtnn/vim-ambiwidth",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		config = function()
			vim.g.ambiwidth_add_list = {
				{ 0x00B7, 0x00B7, 2 },
				{ 0x2018, 0x2019, 2 },
				{ 0x201c, 0x201d, 2 },
				{ 0x2025, 0x2026, 2 },
			}
			vim.g.ambiwidth_cica_enabled = false
		end,
	},
}
