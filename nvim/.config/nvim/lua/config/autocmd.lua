-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank { higroup = "Visual", timeout = 50 }
	end,
})

-- Prevent automatic comment insertion when pressing <Enter> or O
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd "set formatoptions-=cro"
	end,
})

-- Check if the contents of a buffer have changed when opening a buffer
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd "checktime"
	end,
})
