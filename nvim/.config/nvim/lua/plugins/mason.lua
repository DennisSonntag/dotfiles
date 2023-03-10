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
				-- keymap('n', 'gd', function()
				-- 	builtin.lsp_definitions()
				-- end, opts)

				keymap('n', 'gr', function()
					builtin.lsp_references()
				end, opts)

				-- keymap('i', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)

				-- keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)

				-- keymap('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
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
