local function augroup(name)
	return vim.api.nvim_create_augroup("neovim" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- tlescope filepath thing
autocmd("FileType", {
	pattern = "TelescopeResults",
	callback = function(ctx)
		vim.api.nvim_buf_call(ctx.buf, function()
			vim.fn.matchadd("TelescopeParent", "\t\t.*$")
			vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
		end)
	end,
})

-- Highlight when yanking (copying) text
autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 50 })
	end,
})

-- Prevent automatic comment insertion when pressing <Enter> or O
autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
		vim.cmd("set shiftwidth=4")
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
		vim.cmd("set shiftwidth=4")
	end,
})

-- make it easier to close man-files when opened inline
autocmd("FileType", {
	group = augroup("man_unlisted"),
	pattern = { "man" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("WinResize", { clear = true }),
	pattern = "*",
	command = "wincmd =",
	desc = "Auto-resize windows on terminal buffer resize.",
})

autocmd("FileType", {
	group = vim.api.nvim_create_augroup("vertical_help", { clear = true }),
	pattern = "help",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end,
})


local function diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end


autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		-- NOTE: Remember that Lua is a real programming language, and as such it is possible
		-- to define small helper and utility functions so you don't have to repeat yourself.
		--
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func)
			vim.keymap.set("n", keys, func, { buffer = event.buf })
		end

		map("<leader>ds", require("telescope.builtin").lsp_document_symbols)

		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)

		-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
		map("<leader>lvd", vim.diagnostic.open_float)
		map("<leader>cl", "<cmd>LspInfo<cr>")
		map("gd", function()
			require("telescope.builtin").lsp_definitions({ reuse_win = true })
		end)
		map("gr", require("telescope.builtin").lsp_references)
		map("gD", vim.lsp.buf.declaration)
		map("gI", function()
			require("telescope.builtin").lsp_implementations({ reuse_win = true })
		end)
		map("<leader>D", function()
			require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
		end)

		map("<leader>lth", function()
			vim.lsp.inlay_hint(0, nil)
		end)

		map("K", require("hover").hover)
		map("gK", require("hover").hover_select)

		vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help)

		map("]d", diagnostic_goto(true))
		map("[d", diagnostic_goto(false))
		map("]e", diagnostic_goto(true, "ERROR"))
		map("[e", diagnostic_goto(false, "ERROR"))
		map("]w", diagnostic_goto(true, "WARN"))
		map("[w", diagnostic_goto(false, "WARN"))
		-- map("<leader>lf", function()
			-- 	vim.lsp.buf.format { async = true }
			-- end)
			map("<leader>lr", vim.lsp.buf.rename)
			vim.keymap.set({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action)

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.server_capabilities.documentHighlightProvider then
				local highlight_augroup =
				vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- The following autocommand is used to enable inlay hints in your
			-- code, if the language server you are using supports them
			--
			-- This may be unwanted, since they displace some of your code
			if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "[T]oggle Inlay [H]ints")
			end
			vim.cmd("set shiftwidth=4")
		end,
	})
