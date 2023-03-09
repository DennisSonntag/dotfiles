return {
	"jose-elias-alvarez/null-ls.nvim", -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	event = 'BufRead',
	config = function()
		local status, null_ls = pcall(require, "null-ls")
		if (not status) then return end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup {
			sources = {
				null_ls.builtins.formatting.prettierd.with({
					env = {
						PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.prettierrc.json"),
					},
					filetypes = { "astro", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue",
						"css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql",
						"handlebars" },
				}),
				null_ls.builtins.formatting.rustfmt,
				null_ls.builtins.formatting.clang_format,
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.eslint_d.with({
					diagnostics_format = '[eslint] #{m}\n(#{c})'
				}),
			}
		}

		vim.api.nvim_create_user_command(
			'DisableLspFormatting',
			function()
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
			end,
			{ nargs = 0 }
		)
	end
}
