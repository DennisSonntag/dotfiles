return {
{
	"neovim/nvim-lspconfig",
	event = 'BufRead',
	config = function()
		local status, lsp = pcall(require, "lspconfig")
		if (not status) then return end


		local on_attach = function(client, bufnr)
			local keymap = vim.keymap.set

			local opts = { noremap = true, silent = true }

			local status2, builtin = pcall(require, "telescope.builtin")
			if (not status2) then return end

			local bufopts = { noremap = true, silent = true, buffer = bufnr }


			keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)

			keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)

			-- keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
			keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
			-- keymap('n', 'gd', function()
			-- 	builtin.lsp_definitions()
			-- end, opts)

			keymap('n', 'gr', function()
				-- builtin.lsp_definitions()
				builtin.lsp_references()
			end, opts)

			keymap('i', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)

			-- keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)

			-- keymap('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
			keymap('n', '<F2>', vim.lsp.buf.rename, opts)
			keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
			keymap("n", "<leader>lf", function() vim.lsp.buf.format() end)
		end

		local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.offsetEncoding = { "utf-16" }
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		lsp.tsserver.setup {
			on_attach = on_attach,
			filetypes = { "typescript", "typescriptreact", "typescript.tsx", },
			cmd = { "typescript-language-server", "--stdio" }
		}

		local capabilitiesHtml = vim.lsp.protocol.make_client_capabilities()

		-- capabilitiesHtml.textDocument.completion.completionItem.snippetSupport = true
		-- -- Disable formattting for html lsp
		-- capabilitiesHtml.document_formatting = false


		-- lsp.html.setup {
		-- 	capabilities = capabilitiesHtml,
		-- 	cmd = { "vscode-html-language-server", "--stdio" },
		-- 	filetypes = { "html", "typescriptreact", "javascriptreact" },
		-- }


		lsp.astro.setup {
			on_attach = on_attach,
			cmd = { "astro-ls", "--stdio" },
			filetypes = { "astro" },
		}

		lsp.bashls.setup {
			on_attach = on_attach,
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh" }
		}

		lsp.cssls.setup {
			on_attach = on_attach,
			capabilities = capabilities,
			filetypes = { "css", "scss", "less" }
		}

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

		lsp.clangd.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			cmd = { "clangd" },
			filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		})

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

		lsp.tailwindcss.setup({
			on_attach = on_attach,
		})
	end
},

{
	'glepnir/lspsaga.nvim',
	event = 'BufRead',
	config = function()
		local status, saga = pcall(require, "lspsaga")
		if (not status) then return end

		saga.setup({
			symbol_in_winbar = {
				enable = false,
			},
			rename = {
				quit = '<Esc>',
				exec = '<CR>',
				mark = 'x',
				confirm = '<CR>',
				in_select = false,
				whole_project = true,
			},
			ui = {
				-- currently only round theme
				theme = 'round',
				-- border type can be single,double,rounded,solid,shadow.
				border = 'rounded',
				winblend = 0,
				expand = '',
				collapse = '',
				preview = ' ',
				code_action = '💡',
				diagnostic = '🐞',
				incoming = ' ',
				outgoing = ' ',
				colors = {
					--float window normal bakcground color
					normal_bg = '#14161f',
					--title background color
					title_bg = '#5DE4C2',
					red = '#e95678',
					magenta = '#b33076',
					-- orange = '#FF8700',
					orange = '#ffffff',
					yellow = '#f7bb3b',
					green = '#afd700',
					cyan = '#36d0e0',
					blue = '#61afef',
					purple = '#CBA6F7',
					white = '#d1d4cf',
					black = '#1c1c19',
				},
				kind = {},
			},
		})
	end
}


}
