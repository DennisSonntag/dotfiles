return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = function()
		local statusline = require("plugins.lualine.default")
		return {
			options = {
				globalstatus = true,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				theme = 'tokyonight',
				disabled_filetypes = {
					"dashboard",
					"lspinfo",
					"mason",
					"startuptime",
					"checkhealth",
					"help",
					"TelescopePrompt",
					"toggleterm",
					"alpha",
					"lazy",
				},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {
					statusline.branch,
					statusline.mode,
					statusline.diagnostics,
					"%=",
					statusline.lsp,
				},
				lualine_x = {
					statusline.diff,
					statusline.filetype,
					statusline.filesize,
					statusline.progress,
					statusline.percent,
					statusline.total_lines,
				},
				lualine_y = {},
				lualine_z = {},
			},
		}
	end,
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
