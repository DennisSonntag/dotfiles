return {
	"mrjones2014/smart-splits.nvim",
	event = "WinEnter",
	config = function()
		local status, smart_splits = pcall(require, "smart-splits")
		if (not status) then return end

		local keymap = vim.keymap.set

		keymap("n", '<A-Left>', smart_splits.resize_left)
		keymap("n", '<A-Down>', smart_splits.resize_down)
		keymap("n", '<A-Up>', smart_splits.resize_up)
		keymap("n", '<A-Right>', smart_splits.resize_right)


		smart_splits.setup()
	end
}
