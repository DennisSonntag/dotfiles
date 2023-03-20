return {
	'echasnovski/mini.nvim',
	version = false,
	event = 'BufRead',
	dependencies = { "echasnovski/mini.cursorword", "echasnovski/mini.move", "echasnovski/mini.surround",
		"echasnovski/mini.pairs" },
	config = function()
		local status, cursorword = pcall(require, "mini.cursorword")
		if (not status) then return end

		cursorword.setup({
			-- Delay (in ms) between when cursor moved and when highlighting appeared
			delay = 10,
		})

		local status2, move = pcall(require, "mini.move")
		if (not status2) then return end

		move.setup()

		local status4, pairs = pcall(require, "mini.pairs")
		if (not status4) then return end

		pairs.setup()

		local status3, surround = pcall(require, "mini.surround")
		if (not status3) then return end

		surround.setup({
			-- Add custom surroundings to be used on top of builtin ones. For more
			-- information with examples, see `:h MiniSurround.config`.
			custom_surroundings = nil,
			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 500,
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				add = 'msa', -- Add surrounding in Normal and Visual modes
				delete = 'msd', -- Delete surrounding
				find = 'msf', -- Find surrounding (to the right)
				find_left = 'msF', -- Find surrounding (to the left)
				highlight = 'msh', -- Highlight surrounding
				replace = 'msr', -- Replace surrounding
				update_n_lines = 'msn', -- Update `n_lines`
				suffix_last = 'l', -- Suffix to search with "prev" method
				suffix_next = 'n', -- Suffix to search with "next" method
			},
			-- Number of lines within which surrounding is searched
			n_lines = 20,
			-- Whether to respect selection type:
			-- - Place surroundings on separate lines in linewise mode.
			-- - Place surroundings on each line in blockwise mode.
			respect_selection_type = false,
			-- How to search for surrounding (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
			-- see `:h MiniSurround.config`.
			search_method = 'cover',
		})
	end
}
