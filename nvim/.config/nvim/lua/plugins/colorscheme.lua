return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm", -- storm | moon | night | day
		transparent = true,
		styles = {
			sidebars = "transparent", -- style for sidebars, see below
			floats = "transparent", -- style for floating windows
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
	init = function()
		vim.cmd.colorscheme("tokyonight")
	end
}
