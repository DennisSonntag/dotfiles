local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		lazy = true, -- every plugin is lazy-loaded by default
	},
	install = { colorscheme = { "tokyonight" } },
	debug = false,
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("config")

local run_formatter = function(text)
	-- Finds sql-format-via-python somewhere in your nvim config path
	local bin = vim.api.nvim_get_runtime_file("bin/format_prettier_stdio.py", false)[1]
	text = string.sub(text, 4, -3)

	local j = require("plenary.job"):new {
		command = "python",
		args = { bin },
		writer = { text },
	}
	return j:sync()
end

local embedded_html = vim.treesitter.query.parse("rust", [[
 (call_expression
	function: (identifier) @html_func (#eq? @html_func "Html")
	arguments: (arguments ((raw_string_literal) @html (#offset! @html 0 4 -3 0) ))
 )
]]
)

local get_root = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "rust", {})
	local tree = parser:parse()[1]
	return tree:root()
end


local format_dat_html = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	if vim.bo[bufnr].filetype ~= "rust" then
		vim.notify("can only be used in rust")
		return
	end

	local root = get_root(bufnr)

	local changes = {}
	for id, node in embedded_html:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_html.captures[id]
		if name == "html" then
			local range = { node:range() }
			local indentation = string.rep(" ", range[2])

			local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

			for idx, line in ipairs(formatted) do
				formatted[idx] = indentation .. line
			end

			table.insert(changes, 1, { start = range[1] + 1, final = range[3], formatted = formatted })
		end
	end

	for _, change in ipairs(changes) do
		vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
	end
end

vim.api.nvim_create_user_command("FormatHtml", function()
	format_dat_html()
end, {})
