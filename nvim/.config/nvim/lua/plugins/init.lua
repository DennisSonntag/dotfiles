return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	-- {
	-- 	"nvim-tree/nvim-web-devicons",
	-- 	config = true,
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- },
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"okuuva/auto-save.nvim",
		-- event = { "InsertLeave", "TextChanged", "BufReadPre", "BufNewFile" },
		event = { "BufReadPre", "BufNewFile" },
		config = true,
		lazy = true,
	},

	{
		"jinh0/eyeliner.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			highlight_on_key = true,
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
		},
	},
	{
		"utilyre/sentiment.nvim",
		event = { "BufReadPre", "BufNewFile", "BufRead" },
		config = true,
	},
}
