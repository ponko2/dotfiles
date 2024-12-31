return {
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			{
				"hrsh7th/cmp-nvim-lsp",
				dependencies = {
					{
						"j-hui/fidget.nvim",
						opts = {},
					},
					"neovim/nvim-lspconfig",
					{
						"nvimdev/lspsaga.nvim",
						opts = {},
					},
				},
			},
			"hrsh7th/cmp-path",
			{
				"hrsh7th/cmp-vsnip",
				dependencies = { "hrsh7th/vim-vsnip" },
			},
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			}
			opts.mapping = cmp.mapping.preset.insert({
				-- vscode-like mapping
				["<CR>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end,
				}),
				-- vscode-like mapping
				["<TAB>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end,
				}),
				-- vscode-like mapping
				["<S-TAB>"] = cmp.mapping({
					i = function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						else
							fallback()
						end
					end,
				}),
			})
			opts.sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
			}, {
				{ name = "buffer" },
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				completion = { autocomplete = false },
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})

			-- Set up lspconfig.
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- JavaScript/TypeScript
			require("lspconfig")["ts_ls"].setup({
				capabilities = capabilities,
			})

			-- Python
			require("lspconfig")["basedpyright"].setup({
				capabilities = capabilities,
				settings = {
					basedpyright = {
						typeCheckingMode = "off",
					},
				},
			})
		end,
	},
}
