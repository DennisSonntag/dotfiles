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

		-- Split stufff
		keymap("n", "<leader>sv", "<cmd>vsplit<CR>")
		keymap("n", "<leader>sh", "<cmd>split<CR>")
		keymap("n", "<leader>se", "<C-w>=")
		keymap("n", "<leader>ss", "<C-w>R")
		keymap("n", "<leader>stv", "<C-w>t<C-w>H")
		keymap("n", "<leader>sth", "<C-w>t<C-w>K")


		smart_splits.setup()
	end
}
