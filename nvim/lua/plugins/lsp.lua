return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "saghen/blink.cmp" },
			{
				"williamboman/mason.nvim",
				-- NOTE: nixCats: use lazyAdd to only enable mason if nix wasnt involved.
				-- because we will be using nix to download things instead.
				enabled = require("nixCatsUtils").lazyAdd(true, false),
				config = true,
			}, -- NOTE: Must be loaded before dependants
			{
				"williamboman/mason-lspconfig.nvim",
				-- NOTE: nixCats: use lazyAdd to only enable mason if nix wasnt involved.
				-- because we will be using nix to download things instead.
				enabled = require("nixCatsUtils").lazyAdd(true, false),
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				-- NOTE: nixCats: use lazyAdd to only enable mason if nix wasnt involved.
				-- because we will be using nix to download things instead.
				enabled = require("nixCatsUtils").lazyAdd(true, false),
			},

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{
				"folke/lazydev.nvim",
				ft = "lua",
				opts = {
					library = {
						-- adds type hints for nixCats global
						{ path = (require("nixCats").nixCatsPath or "") .. "/lua", words = { "nixCats" } },
					},
				},
			},
			-- kickstart.nvim was still on neodev. lazydev is the new version of neodev
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			local function diagnostic_goto(next, severity)
				local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
				severity = severity and vim.diagnostic.severity[severity] or nil
				return function()
					go({ severity = severity })
				end
			end

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
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

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			-- local capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			-- config.capabilities =
			-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			-- capabilities =
			-- 	vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities(capabilities))

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			-- NOTE: nixCats: there is help in nixCats for lsps at `:h nixCats.LSPs` and also `:h nixCats.luaUtils`
			local servers = {}
			-- servers.clangd = {},
			-- servers.gopls = {},
			-- servers.pyright = {},
			-- servers.rust_analyzer = {},
			-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
			--
			-- Some languages (like typescript) have entire language plugins that can be useful:
			--    https://github.com/pmizio/typescript-tools.nvim
			--
			-- But for many setups, the LSP (`tsserver`) will work just fine
			-- servers.tsserver = {}
			--

			-- NOTE: nixCats: nixd is not available on mason.
			if require("nixCatsUtils").isNixCats then
				servers.nixd = {
					cmd = { "nixd" },
					settings = {
						nixd = {
							nixpkgs = {
								expr = "import <nixpkgs> {}",
							},
						},
						formatting = {
							command = { "alejandra" },
						},
					},
				}
			else
				servers.rnix = {}
				servers.nil_ls = {}
			end

			servers.svelte = {}
			servers.tailwindcss = {}
			servers.cssls = {}
			servers.jsonls = {}
			servers.ts_ls = {}
			servers.basedpyright = {}
			servers.html = {}
			servers.clangd = {
				-- root_dir = function(fname)
				-- 	return require("lspconfig.util").root_pattern(
				-- 		"Makefile",
				-- 		"configure.ac",
				-- 		"configure.in",
				-- 		"config.h.in",
				-- 		"meson.build",
				-- 		"meson_options.txt",
				-- 		"build.ninja"
				-- 	)(fname) or require("lspconfig.util").root_pattern(
				-- 		"compile_commands.json",
				-- 		"compile_flags.txt"
				-- 	)(fname) or require("lspconfig.util").find_git_ancestor(fname)
				-- end,
				-- capabilities = {
				-- 	offsetEncoding = { "utf-16" },
				-- },
				cmd = {
					"clangd",
					-- "--std=c23",
					-- 	"--background-index",
					-- 	"--clang-tidy",
					-- 	"--header-insertion=iwyu",
					-- 	"--completion-style=detailed",
					-- 	"--function-arg-placeholders",
					-- 	"--fallback-style=llvm",
				},
				init_options = {
					fallbackFlags = { "--std=c23" },
					-- 	usePlaceholders = true,
					-- 	completeUnimported = true,
					-- 	clangdFileStatus = true,
				},
			}

			servers.lua_ls = {
				-- cmd = {...},
				-- filetypes = { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = {
							globals = { "nixCats" },
							disable = { "missing-fields" },
						},
					},
				},
			}

			-- NOTE: nixCats: if nix, use lspconfig instead of mason
			-- You could MAKE it work, using lspsAndRuntimeDeps and sharedLibraries in nixCats
			-- but don't... its not worth it. Just add the lsp to lspsAndRuntimeDeps.
			if require("nixCatsUtils").isNixCats then
				for server_name, _ in pairs(servers) do
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
						cmd = (servers[server_name] or {}).cmd,
						root_pattern = (servers[server_name] or {}).root_pattern,
					})
				end
			else
				-- NOTE: nixCats: and if no nix, do it the normal way

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
				})
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				require("mason-lspconfig").setup({
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							-- This handles overriding only values explicitly passed
							-- by the server configuration above. Useful when disabling
							-- certain features of an LSP (for example, turning off formatting for tsserver)
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			-- format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			-- local disable_filetypes = { c = true, cpp = true }
			-- return {
			-- 	timeout_ms = 2500,
			-- 	lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			-- }
			-- end,
			formatters = {
				prettier = {
					prepend_args = { "--config", "~/.prettierrc" },
					-- The base args are { "-filename", "$FILENAME" } so the final args will be
					-- { "-i", "2", "-filename", "$FILENAME" }
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { "prettier" },
				typescript = { "prettier" },
				svelte = { "prettier" },
				json = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				nix = { "alejandra" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				glsl = { "clang-format" },
				vert = { "clang-format" },
				frag = { "clang-format" },
			},
		},
	},
	{ -- Linting
		"mfussenegger/nvim-lint",
		-- NOTE: nixCats: return true only if category is enabled, else false
		enabled = require("nixCatsUtils").enableForCategory("kickstart-lint"),
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
			}

			-- To allow other plugins to add linters to require('lint').linters_by_ft,
			-- instead set linters_by_ft like this:
			-- lint.linters_by_ft = lint.linters_by_ft or {}
			-- lint.linters_by_ft['markdown'] = { 'markdownlint' }
			--
			-- However, note that this will enable a set of default linters,
			-- which will cause errors unless these tools are available:
			-- {
			--   clojure = { "clj-kondo" },
			--   dockerfile = { "hadolint" },
			--   inko = { "inko" },
			--   janet = { "janet" },
			--   json = { "jsonlint" },
			--   markdown = { "vale" },
			--   rst = { "vale" },
			--   ruby = { "ruby" },
			--   terraform = { "tflint" },
			--   text = { "vale" }
			-- }
			--
			-- You can disable the default linters by setting their filetypes to nil:
			-- lint.linters_by_ft['clojure'] = nil
			-- lint.linters_by_ft['dockerfile'] = nil
			-- lint.linters_by_ft['inko'] = nil
			-- lint.linters_by_ft['janet'] = nil
			-- lint.linters_by_ft['json'] = nil
			-- lint.linters_by_ft['markdown'] = nil
			-- lint.linters_by_ft['rst'] = nil
			-- lint.linters_by_ft['ruby'] = nil
			-- lint.linters_by_ft['terraform'] = nil
			-- lint.linters_by_ft['text'] = nil

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
