return {
	{
		"hrsh7th/nvim-cmp",
		event = 'InsertEnter',
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"David-Kunz/cmp-npm",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"f3fora/cmp-spell",
		},
		config = function()
			local status, cmp = pcall(require, "cmp")
			if (not status) then return end

			local status2, lspkind = pcall(require, "lspkind")
			if (not status2) then return end

			local status3, npm = pcall(require, "cmp-npm")
			if (not status3) then return end

			npm.setup({})

			local status4, luasnip = pcall(require, "luasnip")

			if (not status4) then return end

			local cmp_select = { behavior = cmp.SelectBehavior.Select }



			local function contains(list, x)
				for _, v in pairs(list) do
					if v == x then return true end
				end
				return false
			end
			local border_opts = {
				border = "single",
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
				scrollbar = false,
			}



			cmp.setup({
				window = {
					-- completion = cmp.config.window.bordered({ scrollbar = false, side_padding = 1 }),
					-- documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered(border_opts),
					documentation = cmp.config.window.bordered(border_opts),
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.close(),
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
					['<Tab>'] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true
					}),
				}),
				sources = cmp.config.sources({
					{
						name = "nvim_lsp",
						entry_filter = function(entry, ctx)
							if contains({ "javascript", "typescript", "typescriptreact", "javascriptreact" }, ctx.filetype) then
								if contains({ "log", "switch", "case" }, entry:get_word()) then
									return false
								end
							end
							if contains({ "typescriptreact", "javascriptreact" }, ctx.filetype) then
								if entry:get_word() == "class" then
									return false
								end
							end
							if ctx.filetype == "rust" then
								if contains({ "println!", "print!" }, entry:get_word()) then
									return false
								end
							end
							return true
						end
					},
					{ name = 'luasnip' },
					{ name = 'buffer',  keyword_length = 5 },
					{ name = 'npm' },
					{ name = 'nvim_lua' },
					{
						name = 'spell',
						option = {
							keep_all_entries = false,
							enable_in_context = function()
								return require('cmp.config.context').in_treesitter_capture('spell')
							end,
						},
					},
					{ name = 'path' },
				}),
				formatting = {
					format = lspkind.cmp_format({
						with_text = false,
						menu = {
							buffer = "[buf]",
							nvim_lsp = "[LSP]",
							spell = "[spell]",
							nvim_lua = "[vim]",
							path = "[path]",
							luasnip = "[snip]",
						}
					})
				},
				experimental = {
					native_menu = false,
					ghost_text = true,
				}
			})

			vim.cmd([[
				set completeopt=menuone,noinsert,noselect
				highlight! default link CmpItemKind CmpItemMenuDefault
			]])
		end
	},
	{
		"onsails/lspkind.nvim",
		event = 'BufRead',
		after = "hrsh7th/nvim-cmp",
		config = function()
			local status, lspkind = pcall(require, "lspkind")
			if (not status) then return end

			lspkind.init({
				-- enables text annotations
				--
				-- default: true
				mode = 'symbol',
				-- default symbol map
				-- can be either 'default' (requires nerd-fonts font) or
				-- 'codicons' for codicon preset (requires vscode-codicons font)
				--
				-- default: 'default'
				preset = 'codicons',
				-- override preset symbols
				--
				-- default: {}
				symbol_map = {
					Text = "(Text)",
					Method = "(Method)",
					Function = "(Function)",
					Constructor = "(Constructor)",
					Field = "ﰠ(Field)",
					Variable = "(Variable)",
					Class = "ﴯ(Class)",
					Interface = "(Interface)",
					Module = "(Module)",
					Property = "ﰠ(Property)",
					Unit = "塞(Unit)",
					Value = "(Value)",
					Enum = "(Enum)",
					Keyword = "(Keyword)",
					Snippet = "(Snippet)",
					Color = "(Color)",
					File = "(File)",
					Reference = "(Reference)",
					Folder = "(Folder)",
					EnumMember = "(EnumMember)",
					Constant = "(Constant)",
					Struct = "פּ(Struct)",
					Event = "(Event)",
					Operator = "(Operator)",
					TypeParameter = "(TypeParameter)"
				},
			})
		end
	}

}
