return {
	"folke/trouble.nvim",
	event = 'BufRead',
	keys = {
		{ "<leader>xx", "<cmd>TroubleToggle<cr>",          desc = "Toggle Trouble" },
		{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Toggle Trouble Quickfixlist" },
	},
	config = function()
		local status, trouble = pcall(require, "trouble")
		if (not status) then return end

		trouble.setup()
	end
}
