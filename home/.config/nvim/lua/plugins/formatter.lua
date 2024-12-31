return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPost", "BufNewFile", "BufWritePre" },
		opts = {
			format_on_save = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				css = { "biome-check", "prettier", stop_after_first = true },
				javascript = { "biome-check", "prettier", stop_after_first = true },
				javascriptreact = { "biome-check", "prettier", stop_after_first = true },
				lua = { "stylua" },
				python = { "ruff_format", "ruff_fix" },
				typescript = { "biome-check", "prettier", stop_after_first = true },
				typescriptreact = { "biome-check", "prettier", stop_after_first = true },
			},
		},
	},
}
