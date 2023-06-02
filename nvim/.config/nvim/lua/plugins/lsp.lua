return {
	-- inlay hints
	{
		"lvimuser/lsp-inlayhints.nvim",
		branch = "anticonceal",
		event = "LspAttach",
		main = "lsp-inlayhints",
		keys = {
			{
				"<leader>lth", function()
				require('lsp-inlayhints').toggle()
			end
			}

		},
		config = true,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			ui = {
				-- This option only works in Neovim 0.9
				title = true,
				-- Border type can be single, double, rounded, solid, shadow.
				border = "rounded",
				winblend = 0,
				expand = "",
				collapse = "",
				code_action = "💡",
				incoming = " ",
				outgoing = " ",
				hover = ' ',
				kind = {},
			},
		},
	},
	{
		"williamboman/mason.nvim",
		config = true
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = 'BufRead',
		opts = {
			automatic_setup = true,
			automatic_installation = true,
			ensure_installed = { "black", "prettierd", "eslint_d", "clang-format" }
		}
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = 'BufRead',
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
		end,
		config = true,
		init = function()
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
		"neovim/nvim-lspconfig",
		init = function()
			-- disable lsp watcher. Too slow on linux
			local ok, wf = pcall(require, "vim.lsp._watchfiles")
			if ok then
				wf._watchfunc = function()
					return function()
					end
				end
			end
		end,

	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = 'BufRead',
		config = function()
			local status_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
			if (not status_mason_lsp) then return end

			local status_lsp, lsp = pcall(require, "lspconfig")
			if (not status_lsp) then return end

			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			capabilities.offsetEncoding = { "utf-16" }

			local on_attach = function(client, bufnr)
				local keymap = vim.keymap.set

				local status3, builtin = pcall(require, "telescope.builtin")
				if (not status3) then return end

				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				require("lsp-inlayhints").on_attach(client, bufnr)


				keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", bufopts)

				keymap('n', 'gd', builtin.lsp_definitions, bufopts)

				keymap('n', '<leader>lfr', builtin.lsp_references, bufopts)

				keymap("n", "[d", function() vim.diagnostic.goto_next() end, bufopts)
				keymap("n", "]d", function() vim.diagnostic.goto_prev() end, bufopts)



				keymap("n", "<leader>lvd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", bufopts)

				keymap('n', '<leader>lr', vim.lsp.buf.rename, bufopts)
				keymap('n', '<space>lca', "<cmd>Lspsaga code_action<CR>", bufopts)
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
				filetypes = { "rust" },
				cmd = { "rustup", "run", "stable", "rust-analyzer" },
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
	},
	{
		'RubixDev/mason-update-all',
		config = true,
	}
}
