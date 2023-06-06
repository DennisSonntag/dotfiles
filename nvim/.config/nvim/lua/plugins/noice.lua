return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					find = "%d+L, %d+B",
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
		},
	},
	keys = function()
		local noice_status, noice = pcall(require, "noice")
		if not noice_status then return end

		return {
			{
				"<S-Enter>",
				function() noice.redirect(vim.fn.getcmdline()) end,
				mode = "c",
				desc = "Redirect Cmdline"
			},
			{
				"<leader>snl",
				function() noice.cmd("last") end,
				desc = "Noice Last Message"
			},
			{
				"<leader>snh",
				function() noice.cmd("history") end,
				desc = "Noice History"
			},
			{
				"<leader>sna",
				function() noice.cmd("all") end,
				desc = "Noice All"
			},
			{
				"<leader>snd",
				function() noice.cmd("dismiss") end,
				desc = "Dismiss All"
			},
		}
	end,
}
