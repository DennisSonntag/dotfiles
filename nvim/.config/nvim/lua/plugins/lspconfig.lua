return {
	"neovim/nvim-lspconfig",
	config = function()
		local status, lsp = pcall(require, "lspconfig")
		if (not status) then return end

		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.offsetEncoding = { "utf-16" }
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		lsp.tsserver.setup {
			filetypes = { "typescript", "typescriptreact", "typescript.tsx", },
			cmd = { "typescript-language-server", "--stdio" }
		}


		lsp.astro.setup{
			cmd = { "astro-ls", "--stdio" },
			filetypes = { "astro" },
		}

		lsp.bashls.setup{
			cmd ={ "bash-language-server", "start" },
			filetypes = { "sh" }
		}

		lsp.cssls.setup {
			capabilities = capabilities,
			filetypes = { "css", "scss", "less" }
		}

		lsp.lua_ls.setup {
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

		lsp.pyright.setup({
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true
				}
			}
		})

		lsp.clangd.setup({
			capabilities = capabilities,
			cmd = { "clangd" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		})

		lsp.rust_analyzer.setup {
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

		lsp.tailwindcss.setup({
		})
	end
}
