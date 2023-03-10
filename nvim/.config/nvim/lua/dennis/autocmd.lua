local autocmd = vim.api.nvim_create_autocmd

-- Use 'q' to quit from common plugins
autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
	callback = function()
		vim.cmd [[
       nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
	end,
})

-- Remove statusline and tabline when in Alpha
autocmd({ "User" }, {
	pattern = { "AlphaReady" },
	callback = function()
		vim.cmd("set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3")
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

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fixes Autocomment
autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd "set formatoptions-=cro"
	end,
})

--Center on insert mode
autocmd({ "InsertEnter" }, {
	callback = function()
		vim.cmd "norm zz"
	end,
})

-- Highlight Yanked Text
autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
	end,
})

--Center on insert mode
autocmd({ "BufEnter" }, {
	callback = function()
		vim.wo.fillchars = "eob: "
	end,
})


--Open Alpha when buffer empty
vim.api.nvim_create_autocmd("User", {
	pattern = "BDeletePost*",
	callback = function(event)
		local fallback_ft = vim.api.nvim_buf_get_option(event.buf, "filetype")
		if fallback_ft == "" then
			vim.cmd("Alpha")
		end
	end,
})
