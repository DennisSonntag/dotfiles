return {
	"ThePrimeagen/harpoon",
	keys = function()
		local ui = require("harpoon.ui")
		local mark = require("harpoon.mark")

		local keymaps = {
			{ "<leader>a", mark.add_file },
			{ "<C-e>",     ui.toggle_quick_menu },
		}

		for i = 1, 5 do
			table.insert(keymaps, { "<A-" .. i .. ">", function() ui.nav_file(i) end, })
		end

		return keymaps
	end,
}
