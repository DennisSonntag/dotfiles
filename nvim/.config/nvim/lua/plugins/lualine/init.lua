return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lualine = require "lualine"

		local statusline = require "plugins.lualine.default"

		-- if vim.g.dull_style == "slime" then
		--   statusline = require "plugins.lualine.slime"
		-- elseif vim.g.dull_style == "sunset" then
		--   statusline = require "plugins.lualine.sunset"
		-- elseif vim.g.dull_style == "night" then
		--   statusline = require "plugins.lualine.night"
		-- else
		-- statusline = require "plugins.lualine.default"
		-- end

		lualine.setup {
			options = {
				globalstatus = true,
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				theme = "auto",
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
}
