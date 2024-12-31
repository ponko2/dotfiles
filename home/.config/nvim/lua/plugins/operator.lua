return {
	{
		"kana/vim-operator-replace",
		dependencies = { "kana/vim-operator-user" },
		keys = {
			{ "p", [[<Plug>(operator-replace)]], mode = "x" },
		},
	},
	{
		"rhysd/vim-operator-surround",
		dependencies = { "kana/vim-operator-user" },
		keys = {
			{ "sa", [[<Plug>(operator-surround-append)]], mode = { "n", "v", "o" }, { silent = true } },
			{ "sd", [[<Plug>(operator-surround-delete)]], mode = { "n", "v", "o" }, { silent = true } },
			{ "sr", [[<Plug>(operator-surround-replace)]], mode = { "n", "v", "o" }, { silent = true } },
		},
	},
}
