return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
			},
		},
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				fish = { "fish_indent" },
				lua = { "stylua" },
				python = { "black" },
				sh = { "shfmt" },

				["astro"] = { "prettierd" },

				["svelte"] = { "prettierd" },

				["javascript"] = { "prettierd" },
				["javascriptreact"] = { "prettierd" },
				["typescript"] = { "prettierd" },
				["typescriptreact"] = { "prettierd" },
				["vue"] = { "prettierd" },
				["css"] = { "prettierd" },
				["scss"] = { "prettierd" },
				["less"] = { "prettierd" },
				["html"] = { "prettierd" },
				["json"] = { "prettierd" },
				["jsonc"] = { "prettierd" },
				["yaml"] = { "prettierd" },
				["markdown"] = { "prettierd" },
				["markdown.mdx"] = { "prettierd" },
				["graphql"] = { "prettierd" },
				["handlebars"] = { "prettierd" },

				["*"] = { "trim_whitespace" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				-- javascript = { "eslint_d" },
				-- typescript = { "eslint_d" },
				-- javascriptreact = { "eslint_d" },
				-- typescriptreact = { "eslint_d" },
				cpp = { "cpplint" },
				fish = { "fish" },
				python = { "flake8" },
				text = { "vale" },
				dockerfile = { "hadolint" },
				json = { "jsonlint" },
			}

			--
			-- You can disable the default linters by setting their filetypes to nil:
			lint.linters_by_ft["clojure"] = nil
			lint.linters_by_ft["dockerfile"] = nil
			lint.linters_by_ft["inko"] = nil
			lint.linters_by_ft["janet"] = nil
			lint.linters_by_ft["json"] = nil
			lint.linters_by_ft["markdown"] = nil
			lint.linters_by_ft["rst"] = nil
			lint.linters_by_ft["ruby"] = nil
			lint.linters_by_ft["terraform"] = nil
			lint.linters_by_ft["text"] = nil

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		  dir = require("lazy-nix-helper").get_plugin_path("nvim-lspconfig"),
		event = { "BufReadPre", "BufNewFile" },
		enabled = true,
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim",
      enable = require("lazy-nix-helper").mason_enabled(),
						},
			{ "williamboman/mason-lspconfig.nvim", 
								      enable = require("lazy-nix-helper").mason_enabled(),
						},
			{ "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{
				"j-hui/fidget.nvim",
				opts = {
					notification = {
						window = {
							normal_hl = "CursorLineNr", -- Base highlight group in the notification window
							winblend = 0, -- Make the background transparent
							border = "none", -- Border around the notification window
							zindex = 45, -- Stacking priority of the notification window
							max_width = 0, -- Maximum width of the notification window
							max_height = 0, -- Maximum height of the notification window
							x_padding = 1, -- Padding from right edge of window boundary
							y_padding = 0, -- Padding from bottom edge of window boundary
							align = "bottom", -- How to align the notification window
							relative = "editor", -- What the notification window position is relative to
						},
					},
				},
			},

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.diagnostic.config({
				float = {
					border = "rounded",
				},
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 0,
					source = "if_many",
					prefix = "",
				},
				severity_sort = true,
			})

			local function diagnostic_goto(next, severity)
				local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
				severity = severity and vim.diagnostic.severity[severity] or nil
				return function()
					go({ severity = severity })
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
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

					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local util = require("lspconfig/util")

			local servers = {
				astro = {},
				prismals = {},
				bashls = {},
				cssls = {},
				html = {},
				jsonls = {},
				tailwindcss = {
					emmetCompletions = false,
				},
				jdtls = {},
				wgsl_analyzer = {},
				clangd = {},
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_dir = util.root_pattern("go.work", "go.mod", ".git"),
					settings = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
				["svelte-language-server"] = {
					-- TODO: Make this config work to disable emmet completions
					cmd = { "svelteserver", "--stdio" },
					settings = {
						svelte = {
							plugin = {
								css = {
									enabled = false,
									emmet = {
										enable = false,
									},
								},
								html = {
									enabled = false,
									emmet = {
										enable = false, -- Disable Emmet completions for HTML
									},
								},
							},
						},
					},
				},
				pyright = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "workspace",
							useLibraryCodeForTypes = true,
						},
					},
				},
				rust_analyzer = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						runBuildScripts = true,
					},
					-- Add clippy lints for Rust.
					checkOnSave = {
						allFeatures = true,
						command = "clippy",
						extraArgs = { "--no-deps", "--", "-W", "clippy::pedantic", "-W", "clippy::nursery" },
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
				},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				-- But for many setups, the LSP (`tsserver`) will work just fine
				tsserver = {},

				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								--Get the language server to recongnize the "vim" global
								globals = { "vim" },
							},
							workspace = {
								telemetry = { enable = false },
								-- Make the server aware of the Neovim runtime files
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			-- require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"prettier",
				"prettierd",
				"shfmt",
				"yamlfmt",
				"black",
				"clang-format",
				"markdownlint",
				-- "eslint_d",
				"cpplint",
				"flake8",
				"vale",
				"hadolint",
				"jsonlint",
			})
			-- require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- require("mason-lspconfig").setup({
			-- 	handlers = {
			-- 		function(server_name)
			-- 			local server = servers[server_name] or {}
			-- 			-- This handles overriding only values explicitly passed
			-- 			-- by the server configuration above. Useful when disabling
			-- 			-- certain features of an LSP (for example, turning off formatting for tsserver)
			-- 			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			-- 			require("lspconfig")[server_name].setup(server)
			-- 		end,
			-- 	},
			-- })
		end,
	},
	{
		"lewis6991/hover.nvim",
		event = "LspAttach",
		opts = {
			init = function()
				-- Require providers
				require("hover.providers.lsp")
				-- require('hover.providers.gh')
				-- require('hover.providers.gh_user')
				-- require('hover.providers.jira')
				-- require('hover.providers.man')
				-- require('hover.providers.dictionary')
			end,
			preview_opts = {
				border = "rounded",
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = true,
			mouse_providers = {
				"LSP",
			},
			mouse_delay = 1000,
		},
		-- keys = {
		-- 	{ "n", "<C-p>", function() require("hover").hover_switch("previous", { bufnr = 0}) end },
		-- 	{ "n", "<C-n>", function() require("hover").hover_switch("next", {}) end }
		-- }
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "LspAttach",
		main = "lsp_signature",
		config = true,
	},
}
