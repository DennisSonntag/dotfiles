return {
	"mawkler/modicator.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		show_warnings = false,
		highlights = {
			defaults = {
				bold = true,
				italic = false,
			},
		},
	},
}
