local autocmd = vim.api.nvim_create_autocmd

-- Remove statusline and tabline when in Alpha
autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.opt.laststatus = 0
	end,
})

autocmd({ "BufUnload" }, {
	callback = function()
		vim.opt.laststatus = 3
	end,
})

-- Set wrap and spell in markdown and gitcommit
autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "text" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

autocmd({ "FileType" }, {
	pattern = { "gitcommit" },
	callback = function()
		vim.opt.colorcolumn = "80"
	end,
})

-- Fixes Autocomment
autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.opt.formatoptions = "cro"
	end,
})

--Center on insert mode
autocmd({ "InsertEnter" }, {
	callback = function()
		vim.cmd.norm("zz")
	end,
})

-- Highlight Yanked Text
autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank { higroup = "Visual", timeout = 50 }
	end,
})
