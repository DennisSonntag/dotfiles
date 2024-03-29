return {
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function()
			local trouble = require("trouble")
			vim.keymap.set("n", "<leader>xx", function()
				trouble.toggle()
			end)
			vim.keymap.set("n", "<leader>lwd", function()
				trouble.toggle("workspace_diagnostics")
			end)
			vim.keymap.set("n", "<leader>ld", function()
				trouble.toggle("document_diagnostics")
			end)

			-- toggle location list
			vim.keymap.set("n", "<leader>cl", function()
				local win = vim.api.nvim_get_current_win()
				local qf_winid = vim.fn.getloclist(win, { winid = 0 }).winid
				local action = qf_winid > 0 and "lclose" or "lopen"
				vim.cmd(action)
			end)

			-- toggle quickfix list
			vim.keymap.set("n", "<leader>co", function()
				local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
				local action = qf_winid > 0 and "cclose" or "copen"
				vim.cmd("botright " .. action)
			end)

			-- Navigate to next qflist item
			vim.keymap.set("n", "<leader>cn", ":cnext<cr>zz")

			-- Navigate to previos qflist item
			vim.keymap.set("n", "<leader>cp", ":cprevious<cr>zz")

			vim.keymap.set("n", "gR", function()
				trouble.toggle("lsp_references")
			end)
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
		opts = {
			auto_enable = true,
			magic_window = true,
			auto_resize_height = false,
			preview = {
				auto_preview = false,
				show_title = true,
				delay_syntax = 50,
				wrap = false,
			},
			func_map = {
				tab = "t",
				openc = "o",
				drop = "O",
				split = "s",
				vsplit = "v",
				stoggleup = "M",
				stoggledown = "m",
				stogglevm = "m",
				filterr = "f",
				filter = "F",
				prevhist = "<",
				nexthist = ">",
				sclear = "c",
				ptoggleitem = "p",
				ptoggleauto = "a",
				ptogglemode = "P",
			},
		},
	},
}
