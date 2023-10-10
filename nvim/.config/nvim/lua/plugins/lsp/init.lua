return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event        = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"simrat39/rust-tools.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		---@class PluginLspOpts
		opts         = function()
			local util = require("lspconfig/util")

			return {
				-- options for vim.diagnostic.config()
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 0,
						source = "if_many",
						prefix = "",
					},
					severity_sort = true,
				},
				servers = {
					gopls = {
						cmd = { "gopls" },
						filetypes = { "go", "gomod", "gowork", "gotmpl" },
						root_dir = util.root_pattern("go.work", "go.mod", ".git"),
						settings = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true
							}
						}
					},
					qml_lsp = {
						cmd = { "qml-lsp" },
						filetypes = { "qmljs", "qml" }

					},
					pyright = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true
							}
						}

					},
					lua_ls = {
						settings = {
							Lua = {
								diagnostics = {
									--Get the language server to recongnize the "vim" global
									globals = { "vim" }
								},
								workspace = {
									telemetry = { enable = false },
									-- Make the server aware of the Neovim runtime files
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false
								}
							}
						}
					},
				},


			}
		end,

		config       = function(_, opts)
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			function diagnostic_goto(next, severity)
				local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
				severity = severity and vim.diagnostic.severity[severity] or nil
				return function()
					go({ severity = severity })
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buffer = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					vim.keymap.set("n", "<leader>lvd", vim.diagnostic.open_float)
					vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>")
					vim.keymap.set("n", "gd",
						function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end)
					vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>")
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
					vim.keymap.set("n", "gI",
						function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end)
					vim.keymap.set("n", "gy",
						function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end)
					vim.keymap.set("n", "K", vim.lsp.buf.hover)
					vim.keymap.set("n", "<leader>lth", function() vim.lsp.inlay_hint(0, nil) end)
					vim.keymap.set("n", "gK", vim.lsp.buf.signature_help)
					vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help)
					vim.keymap.set("n", "]d", diagnostic_goto(true))
					vim.keymap.set("n", "[d", diagnostic_goto(false))
					vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"))
					vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"))
					vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"))
					vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"))
					vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end)
					vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
					vim.keymap.set({ "n", "v" }, "<leader>lca", vim.lsp.buf.code_action)
				end,
			})




			local servers = opts.servers

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				require("lspconfig")[server].setup(server_opts)
			end

			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end


			local ensure_installed = { "astro", "clangd", "prismals", "bashls", "cssls", "html", "jsonls", "lua_ls",
				"tailwindcss", "tsserver",
				"pyright", "jdtls", "wgsl_analyzer", "gopls" } ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ automatic_installation = false, ensure_installed = ensure_installed, handlers = { setup } })
			end


			local rt = require("rust-tools")

			rt.setup({
				tools = {
					on_initialized = function()
						vim.cmd([[
						  augroup RustLSP
							autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
							autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
							autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
						  augroup END
						]])
					end,
				},
				server = {
					settings = {
						["rust-analyzer"] = {
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
					},
					standalone = false,
					on_attach = function(_, bufnr)
						rt.inlay_hints.disable()
						-- Inlay hints
						vim.keymap.set("n", "<leader>ltr",
							function()
								if vim.g.rustinlaytoggle then
									rt.inlay_hints.disable()
									vim.g.rustinlaytoggle = false
								else
									rt.inlay_hints.enable()
									vim.g.rustinlaytoggle = true
								end
							end
							, { buffer = bufnr })
					end,
				},
			})
		end
	},
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
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function(_, opts)
			local null_ls = require("null-ls")
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
						diagnostics_format = "[eslint] #{m}\n(#{c})",
					}),
				}
			})
		end

	}
}
