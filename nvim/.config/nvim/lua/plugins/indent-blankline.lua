return {
	"lukas-reineke/indent-blankline.nvim",
	event = 'BufRead',
	config = function()
		vim.opt.list = true
		vim.opt.listchars:append "space:⋅"
		vim.opt.listchars:append "eol: "

		local indent_blankline_status, indent_blankline = pcall(require, "indent_blankline")
		if (not indent_blankline_status) then return end

		indent_blankline.setup({
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = false,
		})
	end
}
