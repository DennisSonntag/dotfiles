return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
		transparent = true,
		styles = {
			sidebars = "transparent", -- style for sidebars, see below
			floats = "transparent", -- style for floating windows
		},
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })

		vim.api.nvim_set_hl(0, "LineNr", { fg = "#555f8c" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2d3349", bold = true })

		vim.api.nvim_set_hl(0, "MatchParen", {
			bg = "#3b4261",
		})
	end
}
