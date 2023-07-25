return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v3.x",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>" }
	},
	opts = {
		popup_border_style = "rounded",
		window = {
			position = "float",
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,
			}
		},
	}
}
