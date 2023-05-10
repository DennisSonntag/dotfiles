return {
	{
		"williamboman/mason.nvim",
		config = function()
			local status, mason = pcall(require, "mason")
			if (not status) then return end

			mason.setup()
		end
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = 'BufRead',
		dependencies = { "jose-elias-alvarez/null-ls.nvim" },
		config = function()
			local status, mason_null_ls = pcall(require, "mason-null-ls")
			if (not status) then return end

			local status2, null_ls = pcall(require, "null-ls")
			if (not status2) then return end

			mason_null_ls.setup({
				automatic_setup = true,
				automatic_installation = true,
				ensure_installed = { "black", "prettierd", "eslint_d", "clang-format" }
			})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd.with({
						env = {
							PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.prettierrc.json"),
						},
						filetypes = { "astro", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue",
							"css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "svelte",
							"graphql",
							"handlebars" },
					}),
					null_ls.builtins.diagnostics.eslint_d.with({
						diagnostics_format = '[eslint] #{m}\n(#{c})',
					}),
				}
			})

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			vim.api.nvim_create_user_command(
				'DisableLspFormatting',
				function()
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
				end,
				{ nargs = 0 }
			)
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = 'BufRead',
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			local status_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
			if (not status_mason_lsp) then return end

			local status_lsp, lsp = pcall(require, "lspconfig")
			if (not status_lsp) then return end

			require('lspconfig.ui.windows').default_options.border = 'single'

			vim.cmd("autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335")
			vim.cmd("autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335")
			-- ┌ : used to outline the top-left corner of the floating window.
			-- ─ : used to outline the top and bottom edges of the floating window.
			-- ┐ : used to outline the top-right corner of the floating window.
			-- │ : used to outline the left and right edges of the floating window.
			-- └ : used to outline the bottom-left corner of the floating window.
			-- ┘ :

			local border = {
				{ "┌", "FloatBorder" },

				{ "─", "FloatBorder" },

				{ "┐", "FloatBorder" },

				{ "│", "FloatBorder" },

				{ "┘", "FloatBorder" },

				{ "─", "FloatBorder" },

				{ "└", "FloatBorder" },

				{ "│", "FloatBorder" },
			}

			-- To instead override globally
			local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or border
				return orig_util_open_floating_preview(contents, syntax, opts, ...)
			end

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			capabilities.offsetEncoding = { "utf-16" }

			local on_attach = function(client, bufnr)
				local keymap = vim.keymap.set

				local status3, builtin = pcall(require, "telescope.builtin")
				if (not status3) then return end

				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				keymap('n', 'K', vim.lsp.buf.hover, bufopts)

				keymap('n', 'gd', builtin.lsp_definitions, bufopts)

				keymap('n', '<leader>lfr', builtin.lsp_references, bufopts)

				keymap("n", "[d", function() vim.diagnostic.goto_next() end, bufopts)
				keymap("n", "]d", function() vim.diagnostic.goto_prev() end, bufopts)


				keymap("n", "<leader>lvd", vim.diagnostic.open_float, bufopts)


				keymap('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
				keymap('n', '<space>lca', vim.lsp.buf.code_action, bufopts)
				keymap("n", "<leader>lf", function() vim.lsp.buf.format { async = true } end, bufopts)
			end

			mason_lsp.setup({
				automatic_installation = false,
				ensure_installed = { "astro", "clangd", "prismals", "bashls", "cssls", "html", "jsonls", "lua_ls",
					"tailwindcss", "tsserver",
					"pyright", "jdtls" },
			})

			lsp.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = {"rust"},
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
				['rust-analyzer'] = {
					cargo = {
						allFeatures = true,
					}
				}
			})

			mason_lsp.setup_handlers({
				function(server_name) -- default handler (optional)
					lsp[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
				["pyright"] = function()
					lsp.pyright.setup({
						capabilities = capabilities,
						on_attach = on_attach,
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true
							}
						}
					})
				end,
				["lua_ls"] = function()
					lsp.lua_ls.setup({
						on_attach = on_attach,
						settings = {
							Lua = {
								diagnostics = {
									--Get the language server to recongnize the "vim" global
									globals = { 'vim' }
								},
								workspace = {
									-- Make the server aware of the Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false
								}
							}
						}
					})
				end
			})
		end
	}
}
