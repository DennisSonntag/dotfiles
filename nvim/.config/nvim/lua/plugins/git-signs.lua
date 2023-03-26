return {
	"lewis6991/gitsigns.nvim",
	event = 'BufRead',
	config = function()
		local gitsigns_status, gitsigns = pcall(require, "gitsigns")
		if (not gitsigns_status) then return end

		gitsigns.setup()
	end
}
