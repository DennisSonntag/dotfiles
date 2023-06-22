return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufRead",
	opts = function()
		local char = "▎"
		return {
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
			char = char,
			char_blankline = char,
			context_char = char
		}
	end
}
