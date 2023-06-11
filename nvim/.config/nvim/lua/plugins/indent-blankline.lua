return {
	"lukas-reineke/indent-blankline.nvim",
	event = 'BufRead',
	opts = {
		space_char_blankline = " ",
		show_current_context = true,
		-- context_highlight_list = { "rainbowcol1", "rainbowcol2", "rainbowcol3", "rainbowcol4", "rainbowcol5",
		-- 	"rainbowcol6", "rainbowcol7" },
		show_current_context_start = true,
		char_blankline = "▎",
		-- context_char = "┃",
		-- context_char = "▍"
		context_char = "▎"
	}
}
