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
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = { { "<leader>u", vim.cmd.UndotreeToggle } },
	},
	--Get good kid
	{ "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
