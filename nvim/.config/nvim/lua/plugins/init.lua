return {
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"DaikyXendo/nvim-web-devicons",
		config = true
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = {
			style = "storm",
			transparent = true,
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
			vim.cmd.colorscheme "tokyonight"
			local colors = require("tokyonight.colors").setup(opts)
			vim.api.nvim_set_hl(0, "BqfPreviewFloat", { bg = colors.bg })

			vim.api.nvim_set_hl(0, "Pmenu", { bg = "#2d3349" })
			vim.api.nvim_set_hl(0, "CmpDocumentation", { bg = "#2d3349" })
			vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#404866" })
		end,
	},

	-- Highlight todo, notes, etc in comments
	{ "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = { signs = false } },

	{
		"stevearc/oil.nvim",
		opts = {
			-- Skip the confirmation popup for simple operations
			skip_confirm_for_simple_edits = true,
			-- Deleted files will be removed with the trash_command (below).
			delete_to_trash = true,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		},
		keys = function()
			local oil_status, oil = pcall(require, "oil")
			if not oil_status then
				return
			end

			return { { "-", oil.open } }
		end,
	}
}
