return {
	{
		"mattn/emmet-vim",
		event = "InsertEnter",
		config = function()
			vim.g.user_emmet_settings = { variables = { lang = "ja" } }
		end,
	},
}
