local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

-- Use 'q' to quit from common plugins
autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		keymap("n", "q", "<cmd>close<CR>", { silent = true })
		vim.opt.nobuflisted = true
	end,
})

-- Netrw keymaps
autocmd({ "FileType" }, {
	pattern = { "netrw" },
	callback = function()
		local opts = { noremap = true, silent = true }
		-- Create a new file
		keymap('n', 'a', '<cmd>e %:h/', opts)

		-- Rename a file or directory
		keymap('n', 'r', '<cmd>call netrw#Rename()<CR>', opts)

		-- Create a new directory
		keymap('n', 'd', '<cmd>call netrw#Mkdir()<CR>', opts)

		-- Move or copy a file or directory
		keymap('n', 'm', '<cmd>call netrw#Move()<CR>', opts)

		keymap('n', 'dd', ':call netrw#NetrwDelete()<CR>', opts)
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
