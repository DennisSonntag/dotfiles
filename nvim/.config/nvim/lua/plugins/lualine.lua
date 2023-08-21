local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local mode_names = {
	["n"] = "NORMAL",
	["no"] = "PENDING",
	["nov"] = "PENDING",
	["noV"] = "PENDING",
	["no\22"] = "PENDING",
	["niI"] = "NORMAL",
	["niR"] = "NORMAL",
	["niV"] = "NORMAL",
	["nt"] = "NORMAL",
	["ntT"] = "NORMAL",
	["v"] = "VISUAL",
	["vs"] = "VISUAL",
	["V"] = "V-LINE",
	["Vs"] = "V-LINE",
	["\22"] = "V-BLOCK",
	["\22s"] = "V-BLOCK",
	["s"] = "SELECT",
	["S"] = "S-LINE",
	["\19"] = "S-BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rx"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["Rvc"] = "V-REPLACE",
	["Rvx"] = "V-REPLACE",
	["c"] = "COMMAND",
	["cv"] = "EX",
	["ce"] = "EX",
	["r"] = "REPLACE",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}
local icons = require("config.icons")

local statusline = {
	mode = {
		function()
			local mode_name = vim.api.nvim_get_mode().mode
			if mode_names[mode_name] == nil then
				return mode_name
			end
			return mode_names[mode_name]
		end,
		color = function()
			local mode_color = {
				n = "#7AA2F7",
				no = "#7AA2F7",
				nov = "#7AA2F7",
				noV = "#7AA2F7",
				["no\22"] = "#7AA2F7",
				niI = "#7AA2F7",
				niR = "#7AA2F7",
				ntT = "#7AA2F7",
				nt = "#7AA2F7",
				i = "#98BE65",
				ic = "#ECBE7B",
				ix = "#98BE65",
				v = "#C678DD",
				vs = "#C678DD",
				Vs = "#C678DD",
				[""] = "#C678DD",
				["\22s"] = "#C678DD",
				V = "#C678DD",
				s = "#D19A66",
				S = "#D19A66",
				[""] = "#D19A66",
				R = "#DB4B4B",
				Rc = "#DB4B4B",
				Rv = "#DB4B4B",
				Rx = "#DB4B4B",
				Rvc = "#DB4B4B",
				Rvx = "#DB4B4B",
				c = "#ECBE7B",
				cv = "#7AA2F7",
				ce = "#7AA2F7",
				r = "#DB4B4B",
				rm = "#7DCFFF",
				["r?"] = "#7DCFFF",
				["!"] = "#7AA2F7",
				t = "#7AA2F7",
			}
			return { fg = mode_color[vim.api.nvim_get_mode().mode], bg = "#000F10" }
		end,
	},

	diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn", "hint" },
		symbols = { error = icons.diagnostics.error, warn = icons.diagnostics.warn, hint = icons.diagnostics.hint },
		diagnostics_color = {
			error = { fg = "#DB4B4B" },
			warn = { fg = "#ECBE7B" },
			hint = { fg = "#A9A1E1" },
		},
		update_in_insert = false,
		always_visible = true,
		color = { fg = "#BBC2CF", bg = "#000F10" },
	},

	diff = {
		"diff",
		symbols = { added = icons.git.add, modified = icons.git.change, removed = icons.git.delete },
		diff_color = {
			added = { fg = "#98BE65" },
			modified = { fg = "#7AA2F7" },
			removed = { fg = "#DB4B4B" },
		},
		cond = hide_in_width,
		color = { fg = "#BBC2CF", bg = "#000F10" },
	},
	filename = {
		"filename",
		symbols = { added = icons.git.add, modified = icons.git.change, removed = icons.git.delete },
		diff_color = {
			added = { fg = "#98BE65" },
			modified = { fg = "#7AA2F7" },
			removed = { fg = "#DB4B4B" },
		},
		cond = hide_in_width,
		color = { fg = "#BBC2CF", bg = "#000F10" },
	},
	branch = {
		"branch",
		icons_enabled = true,
		color = { fg = "#BBC2CF", bg = "#000F10" },
		icon = " ",
	},

	filesize = {
		function()
			local function format_file_size(file)
				local size = vim.fn.getfsize(file)
				if size <= 0 then
					return ""
				end
				local sufixes = { " B", " KB", " MB", " GB" }
				local i = 1
				while size > 1024 do
					size = size / 1024
					i = i + 1
				end
				return string.format("%.1f%s", size, sufixes[i])
			end

			local file = vim.fn.expand "%:p"
			if string.len(file) == 0 then
				return ""
			end
			return format_file_size(file)
		end,
		color = { fg = "#BBC2CF", bg = "#000F10" },
	},

	lsp = {
		function()
			local msg = "No Active Lsp"
			local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return msg
			end
			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return client.name
				end
			end
			return msg
		end,

		color = { fg = "#BBC2CF", bg = "#000F10" },
	},

	percent = {
		"progress",
		pading = 0,
		color = { fg = "#BBC2CF", bg = "#000F10" },
	},

	filetype = {
		"filetype",
		color = { fg = "#BBC2CF", bg = "#000F10" },
		pading = 0,
	},

	location = {
		"location",
		color = { fg = "#BBC2CF", bg = "#000F10" },
		pading = 0,
		icon = "󰓾 ",
	},
}

return {
	"nvim-lualine/lualine.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts =
		function()
			local custom_nightfly = require("lualine.themes.nightfly")
			custom_nightfly.normal.c.bg = "#000F10"


			return {
				options = {
					globalstatus = true,
					icons_enabled = true,
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					theme = custom_nightfly,
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
						statusline.mode,
						statusline.diagnostics,
						statusline.branch,
						"%=",
						statusline.lsp,
					},
					lualine_x = {
						statusline.diff,
						statusline.filetype,
						statusline.filename,
						statusline.filesize,
						statusline.location,
						statusline.percent,
					},
					lualine_y = {},
					lualine_z = {},
				},
			}
		end
}
