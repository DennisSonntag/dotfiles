return {
	"mawkler/modicator.nvim",
	event = "BufEnter",
	opts = {
		show_warnings = false,
		highlights = {
			defaults = {
				bold = true,
				italic = false,
			},
		},
	},

	init = function()
		vim.api.nvim_create_autocmd({ "Colorscheme" }, {
			callback = function()
				vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
			end,
		})
	end

}
