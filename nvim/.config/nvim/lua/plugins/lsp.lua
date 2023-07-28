return {
	{
		"RubixDev/mason-update-all",
		main = "mason-update-all",
		cmd = "MasonUpdateAll",
		config = true,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = true
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = "LspAttach",
		opts = {
			automatic_setup = true,
			automatic_installation = true,
			ensure_installed = { "black", "prettierd", "eslint_d", "clang-format" }
		}
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "LspAttach",
		opts = function()
			local null_ls = require("null-ls")
			return {
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
						diagnostics_format = "[eslint] #{m}\n(#{c})",
					}),
				}
			}
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { {
			"neovim/nvim-lspconfig",
			event = "BufRead",
		} },
		event        = "BufRead",
		config       = function()
			local mason_lsp = require("mason-lspconfig")

			local lsp = require("lspconfig")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

			-- Completion configuration
			vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

			capabilities.textDocument.codeLens = { dynamicRegistration = false }

			local on_attach = function(_, bufnr)
				local keymap = vim.keymap.set

				local builtin_status, builtin = pcall(require, "telescope.builtin")
				if (not builtin_status) then return end

				local opts = { buffer = bufnr, remap = false }

				keymap("n", "<leader>lth", function()
					vim.g.inlaytoggle = not vim.g.inlaytoggle
					vim.lsp.inlay_hint(0, vim.g.inlaytoggle)
				end, opts)

				keymap("n", "K", vim.lsp.buf.hover, opts)
				keymap("n", "gd", function() builtin.lsp_definitions({ reuse_win = true }) end, opts)
				keymap("n", "gi", function() builtin.lsp_implementations({ reuse_win = true }) end, opts)

				keymap("n", "<leader>lfr", builtin.lsp_references, opts)
				keymap("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap("n", "]d", vim.diagnostic.goto_next, opts)
				keymap("n", "<leader>lvd", vim.diagnostic.open_float, opts)
				keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)

				keymap({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action, opts)

				keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, opts)
			end

			mason_lsp.setup({
				automatic_installation = false,
				ensure_installed = { "astro", "clangd", "prismals", "bashls", "cssls", "html", "jsonls", "lua_ls",
					"tailwindcss", "tsserver",
					"pyright", "jdtls", "wgsl_analyzer" },
			})

			local rust_analyzer_cmd = { "rustup", "run", "stable", "rust-analyzer" }

			lsp.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = rust_analyzer_cmd,
				["rust-analyzer"] = {
					procMacro = { enable = true },
					cargo = { allFeatures = true },
					checkOnSave = {
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
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
									globals = { "vim" }
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
