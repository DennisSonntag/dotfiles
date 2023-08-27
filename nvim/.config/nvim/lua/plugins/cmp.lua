return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
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
}
