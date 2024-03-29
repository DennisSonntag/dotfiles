return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		style = "storm",
		transparent = true,
		dim_inactive = true, -- dims inactive windows
		lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_highlights = function(hl, _)
			hl.CursorLine = {
				bg = "#2d3349",
				bold = true,
			}
			hl.MatchParen = {
				bg = "#3b4261",
			}
		end,
	},
	init = function(opts)
		vim.cmd.colorscheme("tokyonight")
		local colors = require("tokyonight.colors").setup(opts)
		vim.api.nvim_set_hl(0, "BqfPreviewFloat", { bg = colors.bg })

		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#2d3349" })
		vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = "#2d3349" })
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#404866" })

		-- For Modicator
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
	end,
}
