return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		lsp = {
			signature = {
				enabled = true,
				auto_open = {
					enabled = false,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
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
			bottom_search = false,
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
