return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event        = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"simrat39/rust-tools.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", opts = {} },

		},
		---@class PluginLspOpts
		opts         = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
			},
			servers = {
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


		},

		config       = function(_, opts)
			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buffer = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("plugins.lsp.keymaps").on_attach(client, buffer)
				end,
			})

			local register_capability = vim.lsp.handlers["client/registerCapability"]

			vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
				local ret = register_capability(err, res, ctx)
				local client_id = ctx.client_id
				local client = vim.lsp.get_client_by_id(client_id)
				local buffer = vim.api.nvim_get_current_buf()
				require("plugins.lsp.keymaps").on_attach(client, buffer)
				return ret
			end


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
				"pyright", "jdtls", "wgsl_analyzer" } ---@type string[]
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

			require('neodev').setup()


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
					standalone = false,
					on_attach = function(_, bufnr)
						-- Hover actions
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
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
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = {
			automatic_setup = true,
			automatic_installation = true,
			ensure_installed = { "black", "prettierd", "eslint_d", "clang-format" }
		},
		config = function(_, opts)
			require("mason-null-ls").setup(opts)
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.qmlformat,
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
