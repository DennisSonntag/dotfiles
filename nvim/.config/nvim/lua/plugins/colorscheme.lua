return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm",
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_highlights = function(hl, _)
			hl.CursorLineNr = {
				fg = "#ffffff",
				bold = true,
			}
			hl.LineNr = {
				fg = "#555f8c",
			}
			hl.CursorLine = {
				bg = "#2d3349",
				bold = true,
			}
			hl.MatchParen = {
				bg = "#3b4261",
			}
		end,
	},
	init = function(_, opts)
		vim.cmd.colorscheme("tokyonight")
		local colors = require("tokyonight.colors").setup(opts)
		vim.api.nvim_set_hl(0, "BqfPreviewFloat", { bg = colors.bg })
	end
}
