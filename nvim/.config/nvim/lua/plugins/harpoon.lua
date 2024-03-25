return {
	'ThePrimeagen/harpoon',
	keys = function()
		local ui_status, ui = pcall(require, 'harpoon.ui')
		if not ui_status then
			return
		end

		local mark_staus, mark = pcall(require, 'harpoon.mark')
		if not mark_staus then
			return
		end

		local keymaps = {
			{ '<leader>a', mark.add_file },
			{ '<C-e>',     ui.toggle_quick_menu },
		}
		for i = 1, 5 do
			table.insert(keymaps, {
				'<A-' .. i .. '>',
				function()
					ui.nav_file(i)
				end,
			})
		end

		return keymaps
	end,
}
