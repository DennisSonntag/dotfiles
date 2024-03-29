return {
	"echasnovski/mini.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},
	config = function()
		require("mini.comment").setup({
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		})

		require("mini.ai").setup({
			n_lines = 1000,
			custom_textobjects = {
				--Camel case and snake case
				s = {
					{
						"%u[%l%d]+%f[^%l%d]",
						"%f[%S][%l%d]+%f[^%l%d]",
						"%f[%P][%l%d]+%f[^%l%d]",
						"^[%l%d]+%f[^%l%d]",
					},
					"^().*()$",
				},
			},
		})

		require("mini.move").setup()
		require("mini.splitjoin").setup()

		require("mini.surround").setup({
			custom_surroundings = {
				["q"] = { output = { left = "'", right = "'" } },
				["Q"] = { output = { left = '"', right = '"' } },
				["B"] = { output = { left = "{", right = "}" } },
				["["] = { output = { left = "[", right = "]" } },
				["<"] = { output = { left = "<", right = ">" } },
			},
			mappings = {
				add = "msa", -- Add surrounding in Normal and Visual modes
				delete = "msd", -- Delete surrounding
				find = "msf", -- Find surrounding (to the right)
				find_left = "msF", -- Find surrounding (to the left)
				highlight = "msh", -- Highlight surrounding
				replace = "msr", -- Replace surrounding
				update_n_lines = "msn", -- Update `n_lines`
			},
		})
	end,
}
