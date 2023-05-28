return {
	'echasnovski/mini.nvim',
	version = false,
	event = 'BufRead',
	dependencies = { "echasnovski/mini.cursorword", "echasnovski/mini.move", "echasnovski/mini.surround",
		"echasnovski/mini.surround",
		"echasnovski/mini.pairs", "echasnovski/mini.indentscope" },
	config = function()
		local cursorword_status, cursorword = pcall(require, "mini.cursorword")
		if (not cursorword_status) then return end

		cursorword.setup({
			delay = 10,
		})

		local indentscope_status, indentscope = pcall(require, "mini.indentscope")
		if (not indentscope_status) then return end

		indentscope.setup()

		local move_status, move = pcall(require, "mini.move")
		if (not move_status) then return end

		move.setup()

		local ai_status, ai = pcall(require, "mini.ai")
		if (not ai_status) then return end

		-- local spec_treesitter = require('mini.ai').gen_spec.treesitter
		ai.setup({
			custom_textobjects = {
				--Camel case
				s = {
					{
						'%u[%l%d]+%f[^%l%d]',
						'%f[%S][%l%d]+%f[^%l%d]',
						'%f[%P][%l%d]+%f[^%l%d]',
						'^[%l%d]+%f[^%l%d]',
					},
					'^().*()$'
				}
			}
		})


		local pairs_status, pairs = pcall(require, "mini.pairs")
		if (not pairs_status) then return end

		pairs.setup()

		local surround_status, surround = pcall(require, "mini.surround")
		if (not surround_status) then return end

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
