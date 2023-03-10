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

			mason_null_ls.setup_handlers {
				function(source_name, methods)
					-- all sources with no handler get passed here

					-- To keep the original functionality of `automatic_setup = true`,
					-- please add the below.
					require("mason-null-ls.automatic_setup")(source_name, methods)
				end,
			}

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd.with({
						env = {
							PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.prettierrc.json"),
						},
						filetypes = { "astro", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue",
							"css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx",
							"graphql",
							"handlebars" },
					}),
					-- null_ls.builtins.formatting.rustfmt,
					-- null_ls.builtins.formatting.clang_format,
					-- null_ls.builtins.formatting.black,
					null_ls.builtins.diagnostics.eslint_d.with({
						diagnostics_format = '[eslint] #{m}\n(#{c})'
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
			local status2, mason_lsp = pcall(require, "mason-lspconfig")
			if (not status2) then return end

			local status_lsp, lsp = pcall(require, "lspconfig")
			if (not status_lsp) then return end

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			capabilities.offsetEncoding = { "utf-16" }

			local on_attach = function(client, bufnr)
				local keymap = vim.keymap.set

				local opts = { noremap = true, silent = true }

				local status3, builtin = pcall(require, "telescope.builtin")
				if (not status3) then return end

				local bufopts = { noremap = true, silent = true, buffer = bufnr }


				keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)


				keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
				keymap('n', 'gr', function()
					builtin.lsp_references()
				end, opts)
				keymap('n', '<F2>', vim.lsp.buf.rename, opts)
				keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
				keymap("n", "<leader>lf", function() vim.lsp.buf.format() end)
			end

			mason_lsp.setup({
				automatic_installation = true,
				ensure_installed = { "astro", "clangd", "prismals", "bashls", "cssls", "html", "jsonls", "lua_ls",
					"tailwindcss", "tsserver",
					"pyright", "jdtls" },
			})

			mason_lsp.setup_handlers {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {
						on_attach = on_attach,
						capabilities = capabilities,
					}
				end,

				["rust_analyzer"] = function()
					lsp.rust_analyzer.setup {
						on_attach = on_attach,
						cmd = {
							"rustup", "run", "stable", "rust-analyzer"
						},
						settings = {
							["rust-analyzer"] = {
								checkOnSave = {
									command = "clippy",
								},
							},
						},
					}
				end,
				["pyright"] = function()
					lsp.pyright.setup({
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
					lsp.lua_ls.setup {
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
					}
				end
			}
		end
	}
}
