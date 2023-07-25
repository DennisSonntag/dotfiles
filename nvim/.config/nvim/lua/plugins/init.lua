return {
	--Required for a bunch of plugins
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = true,
	},
	{
		"stevearc/dressing.nvim",
		opts = {},
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = { { "<leader>u", vim.cmd.UndotreeToggle } },
	},
	--Get good kid
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
