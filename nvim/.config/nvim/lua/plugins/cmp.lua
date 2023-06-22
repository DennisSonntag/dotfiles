return { {
	"hrsh7th/nvim-cmp",
	dependencies = {
		event = "InsertEnter",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		{ "David-Kunz/cmp-npm", config = true },
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"f3fora/cmp-spell",
	},
	opts = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local function contains(list, x)
			for _, v in pairs(list) do
				if v == x then return true end
			end
			return false
		end
		local icons = require("config.icons")
		return {
			window = {
				completion = cmp.config.window.bordered({ scrollbar = false, side_padding = 1 }),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
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
				{
					name = "crates",
					entry_filter = function(_, ctx)
						if not contains({ "toml", "rust" }, ctx.filetype) then
							return false
						end
						return true
					end
				},
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
}
}
