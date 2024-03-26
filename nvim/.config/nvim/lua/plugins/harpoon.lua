return {
	'ThePrimeagen/harpoon',
	branch = "harpoon2",
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

		vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

	end,
	-- keys = function()
	-- 	local ui_status, ui = pcall(require, 'harpoon.ui')
	-- 	if not ui_status then
	-- 		return
	-- 	end
	--
	-- 	local mark_staus, mark = pcall(require, 'harpoon.mark')
	-- 	if not mark_staus then
	-- 		return
	-- 	end
	--
	-- 	local function mark_file()
	-- 		mark.add_file()
	-- 		vim.notify "󱡅  marked file"
	-- 	end
	--
	-- 	local keymaps = {
	-- 		{ '<leader>a', mark_file },
	-- 		{ '<C-e>',     ui.toggle_quick_menu },
	-- 	}
	-- 	for i = 1, 5 do
	-- 		table.insert(keymaps, {
	-- 			'<A-' .. i .. '>',
	-- 			function()
	-- 				ui.nav_file(i)
	-- 			end,
	-- 		})
	-- 	end
	--
	-- 	return keymaps
	-- end,
}
