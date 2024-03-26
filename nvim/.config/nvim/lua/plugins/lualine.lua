local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

return {
	"nvim-lualine/lualine.nvim",
	-- dependencies = "letieu/harpoon-lualine"

	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
			icons_enabled = true,
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
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				"diagnostics",
				"%=",
				{
					"filename",
					path = 1,
					symbols = { added = require("config.icons").git.add, modified = require("config.icons").git.change, removed = require("config.icons").git.delete },
					diff_color = {
						added = { fg = "#98BE65" },
						modified = { fg = "#7AA2F7" },
						removed = { fg = "#DB4B4B" },
					},
					cond = hide_in_width,
				},
			},

			-- lualine_x = { "harpoon2", "location" },
			lualine_x = { "location" },
			lualine_y = { "filetype" },
			lualine_z = { "progress" },
		},
		extensions = { "quickfix", "man", "fugitive" },
	}
}
