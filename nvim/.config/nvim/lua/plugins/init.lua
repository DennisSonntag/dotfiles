return {
	{ "lewis6991/gitsigns.nvim", config = true },
	{ "nvim-tree/nvim-web-devicons", config = true },
	{ "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },

	{ "okuuva/auto-save.nvim", event = { "InsertLeave", "TextChanged" }, config = true },

	{
		"jinh0/eyeliner.nvim",
		event = "VeryLazy",
		opts = {
			highlight_on_key = true,
		},
	},
	{
		"windwp/nvim-autopairs",
		opts = {
			check_ts = true,
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
		},
	},
	{
		"andymass/vim-matchup",
		init = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"utilyre/sentiment.nvim",
		event = "BufRead",
		config = true,
		init = function()
			vim.g.loaded_matchparen = 1 -- `matchparen.vim` needs to be disabled manually in case of lazy loading
		end,
	},
}
