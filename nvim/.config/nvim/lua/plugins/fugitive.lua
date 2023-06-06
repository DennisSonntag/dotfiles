return {
	"tpope/vim-fugitive",
	cmd = "Git",
	keys = {
		{ "<leader>gl", function() vim.cmd.Git('log --graph --oneline --decorate') end },
		{ "<leader>ga", function() vim.cmd.Git('add .') end },
		{ "<leader>gc", function() vim.cmd.Git('commit') end }
	}
}
