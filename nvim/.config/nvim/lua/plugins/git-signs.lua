return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local status, gitsigns = pcall(require, "gitsigns")
		if (not status) then return end

		gitsigns.setup()
	end
}
