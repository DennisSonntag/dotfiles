return {
	{
		'RubixDev/mason-update-all',
		main = "mason-update-all",
		cmd = "MasonUpdateAll",
		config = true,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts =
			function()
				local icons = require("config.icons")

				return {
					symbol_in_winbar = {
						enable = false,
					},
					lightbulb = {
						enable = false,
					},
					ui = {
						-- This option only works in Neovim 0.9
						title = true,
						border = "rounded", -- single | double | rounded | solid | shadow
						winblend = 0,
						expand = icons.folder.expanded,
						collapse = icons.folder.collapsed,
						code_action = icons.diagnostics.hint,
						incoming = " ",
						outgoing = " ",
						hover = ' ',
						kind = {},
					},
				}
			end
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
						diagnostics_format = '[eslint] #{m}\n(#{c})',
					}),
				}
			}
		end
		-- init = function()
		-- 	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		--
		-- 	vim.api.nvim_create_user_command(
		-- 		'DisableLspFormatting',
		-- 		function()
		-- 			vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
		-- 		end,
		-- 		{ nargs = 0 }
		-- 	)
		-- end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { {
			"neovim/nvim-lspconfig",
			event = 'BufRead',
			-- init = function()
			-- 	-- disable lsp watcher. Too slow on linux
			-- 	local ok, wf = pcall(require, "vim.lsp._watchfiles")
			-- 	if ok then
			-- 		wf._watchfunc = function()
			-- 			return function()
			-- 			end
			-- 		end
			-- 	end
			-- end,

		} },
		event        = 'BufRead',
		config       = function()
			local mason_lsp = require("mason-lspconfig")

			local lsp = require("lspconfig")

			-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
			-- capabilities.offsetEncoding = { "utf-16" }

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true
			capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

			-- Completion configuration
			vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

			capabilities.textDocument.codeLens = { dynamicRegistration = false }

			local on_attach = function(client, bufnr)
				local keymap = vim.keymap.set

				local status3, builtin = pcall(require, "telescope.builtin")
				if (not status3) then return end

				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				-- vim.lsp.buf.inlay_hint(0, vim.g.inlaytoggle)

				require("nvim-navic").attach(client, bufnr)

				keymap("n", "<leader>lth", function()
					vim.g.inlaytoggle = not vim.g.inlaytoggle
					vim.lsp.buf.inlay_hint(0, vim.g.inlaytoggle)
				end, bufopts)

				keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)
				keymap('n', 'gd', builtin.lsp_definitions, bufopts)
				keymap('n', 'gi', builtin.lsp_implementations, bufopts)
				keymap('n', '<leader>lfr', builtin.lsp_references, bufopts)
				keymap("n", "[d", vim.diagnostic.goto_next, bufopts)
				keymap("n", "]d", vim.diagnostic.goto_prev, bufopts)
				keymap("n", "<leader>lvd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", bufopts)
				keymap('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
				keymap('n', '<space>lca', "<cmd>Lspsaga code_action<CR>", bufopts)
				keymap("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, bufopts)
			end

			mason_lsp.setup({
				automatic_installation = false,
				ensure_installed = { "astro", "clangd", "prismals", "bashls", "cssls", "html", "jsonls", "lua_ls",
					"tailwindcss", "tsserver",
					"pyright", "jdtls", "wgsl_analyzer" },
			})

			-- local rust_analyzer_cmd = { "rustup", "run", "nightly", "rust-analyzer" }
			local rust_analyzer_cmd = { "rustup", "run", "stable", "rust-analyzer" }

			lsp.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = rust_analyzer_cmd,
				['rust-analyzer'] = {
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
