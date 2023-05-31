return {
	{
		"echasnovski/mini.cursorword",
		event = 'BufRead',
		opts = {
			delay = 10,

		}
	},
	{
		"echasnovski/mini.indentscope",
		event = 'BufRead',
		config = true
	},
	{
		"echasnovski/mini.move",
		event = 'BufRead',
		config = true
	},
	{
		"echasnovski/mini.pairs",
		event = 'BufRead',
		config = true
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring', lazy = true },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo
					.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.ai",
		event = 'BufRead',
		opts = {
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

		}
	},
	{
		"echasnovski/mini.surround",
		event = 'BufRead',
		opts = {
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
		}
	},
	{
		'echasnovski/mini.nvim',
		version = false,
		event = 'BufRead',
	} }
