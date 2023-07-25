return {
	{ "echasnovski/mini.cursorword", event = "BufRead", opts = { delay = 10, } },
	{ "echasnovski/mini.move",       event = "BufRead", config = true },
	{ "echasnovski/mini.pairs",      event = "BufRead", config = true },
	{
		"echasnovski/mini.comment",
		event = "BufRead",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
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
		event = "BufRead",
		opts = {
			custom_textobjects = {
				--Camel case
				s = {
					{
						"%u[%l%d]+%f[^%l%d]",
						"%f[%S][%l%d]+%f[^%l%d]",
						"%f[%P][%l%d]+%f[^%l%d]",
						"^[%l%d]+%f[^%l%d]",
					},
					"^().*()$"
				}
			}

		}
	},
	{
		"echasnovski/mini.surround",
		event = "BufRead",
		opts = {
			mappings = {
				add = "msa", -- Add surrounding in Normal and Visual modes
				delete = "msd", -- Delete surrounding
				find = "msf", -- Find surrounding (to the right)
				find_left = "msF", -- Find surrounding (to the left)
				highlight = "msh", -- Highlight surrounding
				replace = "msr", -- Replace surrounding
				update_n_lines = "msn", -- Update `n_lines`
			},
		}
	},
}
