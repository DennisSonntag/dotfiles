return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format { async = true, lsp_fallback = true }
				end,
			},
		},
		opts = {
			notify_on_error = false,
			formatters_by_ft = {
				astro = { { "prettierd", "prettier" } },
				c = { "clang_format" },
				cpp = { "clang_format" },
				css = { { "prettierd", "prettier" } },
				fish = { "fish_indent" },
				graphql = { { "prettierd", "prettier" } },
				handlebars = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
				less = { { "prettierd", "prettier" } },
				lua = { "stylua" },
				markdown = { { "prettierd", "prettier" } },
				python = { "black" },
				scss = { { "prettierd", "prettier" } },
				sh = { "shfmt" },
				svelte = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				vue = { { "prettierd", "prettier" } },
				yaml = { "yamlfmt" },
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
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
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
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

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
				}
			},

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.diagnostic.config {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 0,
					source = "if_many",
					prefix = "",
				},
				severity_sort = true,
			}

			local function diagnostic_goto(next, severity)
				local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
				severity = severity and vim.diagnostic.severity[severity] or nil
				return function()
					go { severity = severity }
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
						require("telescope.builtin").lsp_definitions { reuse_win = true }
					end)
					map("gr", require("telescope.builtin").lsp_references)
					map("gD", vim.lsp.buf.declaration)
					map("gI", function()
						require("telescope.builtin").lsp_implementations { reuse_win = true }
					end)
					map("<leader>D", function()
						require("telescope.builtin").lsp_type_definitions { reuse_win = true }
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
					map("<leader>lf", function()
						vim.lsp.buf.format { async = true }
					end)
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
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local util = require("lspconfig/util")

			local servers = {
				astro = {},
				prismals = {},
				bashls = {},
				cssls = {},
				html = {},
				jsonls = {},
				tailwindcss = {},
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
				["svelte-language-server"] = {},
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
			require("mason").setup()

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
				"eslint_d",
				"cpplint",
				"flake8",
				"vale",
				"hadolint",
				"jsonlint",
			})
			require("mason-tool-installer").setup { ensure_installed = ensure_installed }

			require("mason-lspconfig").setup {
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		after = "saadparwaiz1/cmp_luasnip",
		dependencies = {
			{ "hrsh7th/cmp-buffer",       event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lsp",     event = "InsertEnter" },
			{ "hrsh7th/cmp-path",         event = "InsertEnter" },
			{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
			{ "hrsh7th/cmp-nvim-lua",     event = "InsertEnter" },
			{ "f3fora/cmp-spell",         event = "InsertEnter" },
			{ "David-Kunz/cmp-npm",       config = true,        event = "InsertEnter" },
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local icons = require("config.icons")

			local lspkind_comparator = function(conf)
				local lsp_types = require("cmp.types").lsp
				return function(entry1, entry2)
					if entry1.source.name ~= "nvim_lsp" then
						if entry2.source.name == "nvim_lsp" then
							return false
						else
							return nil
						end
					end
					local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
					local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

					local priority1 = conf.kind_priority[kind1] or 0
					local priority2 = conf.kind_priority[kind2] or 0
					if priority1 == priority2 then
						return nil
					end
					return priority2 < priority1
				end
			end

			local label_comparator = function(entry1, entry2)
				return entry1.completion_item.label < entry2.completion_item.label
			end

			return {
				view = {
					entries = { name = "custom", selection_order = "near_cursor" },
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sorting = {
					-- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
					comparators = {
						lspkind_comparator({
							kind_priority = {
								Field = 11,
								Property = 11,
								Constant = 10,
								Enum = 10,
								EnumMember = 11,
								Event = 10,
								Function = 10,
								Method = 10,
								Operator = 10,
								Reference = 10,
								Struct = 10,
								Variable = 9,
								File = 8,
								Folder = 8,
								Class = 5,
								Color = 5,
								Module = 5,
								Keyword = 2,
								Constructor = 1,
								Interface = 1,
								Snippet = 2,
								Text = 10,
								TypeParameter = 1,
								Unit = 1,
								Value = 1,
							},
						}),
						label_comparator,
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<C-n>"] = cmp.mapping(function(fallback)
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-p>"] = cmp.mapping(function(fallback)
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Tab>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "crates" },
					{ name = "luasnip" },
					{ name = "buffer",  keyword_length = 5 },
					{ name = "npm" },
					{ name = "nvim_lua" },
					{
						name = "spell",
						option = {
							keep_all_entries = false,
							enable_in_context = function()
								return require("cmp.config.context").in_treesitter_capture("spell")
							end,
						},
					},
					{ name = "path" },
				}),
				formatting = {
					format = function(entry, item)
						-- Kind icons
						item.kind = string.format("%s %s", icons.kinds[item.kind], item.kind) -- This concatonates the icons with the name of the item kind
						-- Source
						item.menu = ({
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[LaTeX]",
						})[entry.source.name]
						return item
					end
				},
				experimental = {
					native_menu = false,
					ghost_text = true,
				}

			}
		end,
	},
	{
		"zeioth/garbage-day.nvim",
		dependencies = "neovim/nvim-lspconfig",
		event = "VeryLazy",
		config = true,
	},
	{
		"lewis6991/hover.nvim",
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
				border = 'rounded'
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = true,
			mouse_providers = {
				'LSP'
			},
			mouse_delay = 1000
		},
		-- keys = {
		-- 	{ "n", "<C-p>", function() require("hover").hover_switch("previous", { bufnr = 0}) end },
		-- 	{ "n", "<C-n>", function() require("hover").hover_switch("next", {}) end }
		-- }
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		main = "lsp_signature",
		config = true
	}
}
