return {
	--Required for a bunch of plugins
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{
		"tpope/vim-fugitive",
		lazy = true,
		keys = {
			{ "<leader>gl", function()
				vim.cmd.Git('log --graph --oneline --decorate')
			end },

			{ "<leader>ga", function()
				vim.cmd.Git('add .')
			end },

			{ "<leader>gc", function()
				vim.cmd.Git('commit')
			end }

		}
	},
	{
		"Pocco81/auto-save.nvim",
		event = 'BufRead',
		config = true
	},
	{
		"lewis6991/gitsigns.nvim",
		event = 'BufRead',
		config = true,
	},
	{
		"mbbill/undotree",
		event = 'BufRead',
		keys = { { "<leader>u", vim.cmd.UndotreeToggle } },
	},

	--Get good kid
	{ "ThePrimeagen/vim-be-good", event = "VeryLazy" },


	--Urgent deadline approaches? Don't worry. With this plugin you can procrastinate even more!
	-- { "eandrju/cellular-automaton.nvim", event = "VeryLazy" },
}
