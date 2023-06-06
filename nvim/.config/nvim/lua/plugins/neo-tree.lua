return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "NeoTreeFloatToggle",
	keys = {
		{ "<leader>e", "<cmd>NeoTreeFloatToggle<CR>" }
	},
	opts = {
		popup_border_style = "rounded",
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				hide_hidden = false,

			}
		},
	}
}
