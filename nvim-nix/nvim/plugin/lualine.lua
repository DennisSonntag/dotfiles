local autocmd = vim.api.nvim_create_autocmd

local status, lualine = pcall(require, 'lualine') 
if not status then
  return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local harpoon = require("harpoon.mark")


-- autocmd({ "BufReadPre", "BufNewFile" }, {
-- 	callback = function()
		lualine.setup({
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
				lualine_a = { { "mode", separator = { right = "" } } },
				lualine_b = { { "branch", separator = { right = "" } } },
				lualine_c = {
					"diagnostics",
					function()
						local total_marks = harpoon.get_length()

						if total_marks == 0 then
							return ""
						end

						local current_mark = "—"

						local mark_idx = harpoon.get_current_index()
						if mark_idx ~= nil then
							current_mark = tostring(mark_idx)
						end

						return string.format("󱡅 %s/%d", current_mark, total_marks)
					end,
					"%=",
					{
						"filename",
						path = 1,
						symbols = {
							added = require("user.icons").git.add,
							modified = require("user.icons").git.change,
							removed = require("user.icons").git.delete,
						},
						diff_color = {
							added = { fg = "#98BE65" },
							modified = { fg = "#7AA2F7" },
							removed = { fg = "#DB4B4B" },
						},
						cond = hide_in_width,
					},
				},

				lualine_x = { "location" },
				lualine_y = { { "filetype", separator = { left = "" } } },
				lualine_z = { { "progress", separator = { left = "" } } },
			},
			extensions = { "quickfix", "man", "fugitive" },
		})
-- 	end,
-- })


