local function augroup(name)
	return vim.api.nvim_create_augroup("neovim" .. name, { clear = true })
end
local DennisGroup = augroup('Dennis')
local autocmd = vim.api.nvim_create_autocmd

-- Highlight when yanking (copying) text
autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank { higroup = "Visual", timeout = 50 }
	end,
})

-- Prevent automatic comment insertion when pressing <Enter> or O
autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Check if the contents of a buffer have changed when opening a buffer
-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave", "BufWinEnter" }, {
	group = augroup("checktime"),
	pattern = { "*" },
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- remove post line space
autocmd({ "BufWritePre" }, {
	group = DennisGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- go to last location when opening a buffer
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})
