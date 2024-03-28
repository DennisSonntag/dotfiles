return {
	"stevearc/oil.nvim",
	opts = {
		skip_confirm_for_simple_edits = true,
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
	},
	keys = { { "-", function() require("oil").open() end } }
}
