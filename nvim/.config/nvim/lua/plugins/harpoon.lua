return {
	"ThePrimeagen/harpoon",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		local opts = { noremap = true, silent = true }

		local keymap = vim.keymap.set

		keymap("n", "<leader>a", mark.add_file)
		keymap("n", "<C-e>", ui.toggle_quick_menu)

		keymap("n", "<A-1>", function() ui.nav_file(1) end, opts)
		keymap("n", "<A-2>", function() ui.nav_file(2) end, opts)
		keymap("n", "<A-3>", function() ui.nav_file(3) end, opts)
		keymap("n", "<A-4>", function() ui.nav_file(4) end, opts)
		keymap("n", "<A-5>", function() ui.nav_file(5) end, opts)
	end
}
