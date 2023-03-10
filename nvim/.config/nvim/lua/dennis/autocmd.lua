local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local DennisGroup = augroup('dennis', {})

-- Use 'q' to quit from common plugins
autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close<CR>", { silent = true })
		vim.opt.nobuflisted = true
	end,
})

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
	pattern = { "gitcommit", "markdown" },
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


--Remove Trailing whitespace
autocmd({ "BufWritePre" }, {
	group = DennisGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})
