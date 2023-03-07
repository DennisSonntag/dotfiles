return {
	"L3MON4D3/LuaSnip",
	config = function()
		-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins/snippets/<CR>")

		local ls = require("luasnip") --{{{

		-- require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/plugins/snippets/" })
		require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

		vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

		-- Virtual Text{{{
		local types = require("luasnip.util.types")
		ls.config.set_config({
			history = true,                   --keep around last snippet local to jump back
			updateevents = "TextChanged,TextChangedI", --update changes as you type
			enable_autosnippets = true,
			ext_opts = {
					[types.choiceNode] = {
					active = {
						virt_text = { { "●", "GruvboxOrange" } },
					},
				},
				-- [types.insertNode] = {
				-- 	active = {
				-- 		virt_text = { { "●", "GruvboxBlue" } },
				-- 	},
				-- },
			},
		}) --}}}

		local s = ls.s
		local i = ls.i
		local t = ls.t

		local d = ls.dynamic_node
		local c = ls.choice_node
		local f = ls.function_node
		local sn = ls.snippet_node


		local fmt = require("luasnip.extras.fmt").fmt
		local rep = require("luasnip.extras").rep

		for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			ls.add_snippets(lang, {
				s("log", fmt("console.log({});", {
					i(1, "")
				})),
				s("af", fmt("const {} = () => {{\n {}\t\n}};", {
					i(1, "name"),
					i(2, ""),
				})),
				s("for", fmt([[
					for (let {} = 0; {} < {}; {}++) {{
						{}
					}}
				]], { i(1, "i"), rep(1), i(2, "length"), rep(1), i(3) })),
				s("forof", fmt([[
					for (const {} of {}) {{
						{}
					}}
				]], { i(1, "i"), i(2, "iterator"), i(3) })),
				s("forin", fmt([[
					for (const {} in {}) {{
						{}
					}}
				]], { i(1, "i"), i(2, "iterator"), i(3) })),
				s("foreach", fmt([[
					{}.foreach({} => {{
						{}
					}});
				]], { i(1, "array"), i(2, "elm"), i(3) })),
				s("map", fmt([[
					{}.map({} => {{
						{}
					}});
				]], { i(1, "array"), i(2, "elm"), i(3) })),
				s("filter", fmt([[
					{}.filter({} => {{
						{}
					}});
				]], { i(1, "array"), i(2, "elm"), i(3) })),
				s("if", fmt([[
					if ({}) {{
						{}
					}}
				]], { i(1, "condition"), i(2, "") })),
				s("elseif", fmt([[
					else if ({}) {{
						{}
					}}
				]], { i(1, "condition"), i(2, "") })),
				s("else", fmt([[
					else {{
						{}
					}}
				]], { i(1, "") })),
				s("while", fmt([[
					while ({}) {{
						{}
					}}
				]], { i(1, "condition"), i(2, "") })),
				s("dowhile", fmt([[
					do {{
						{}
					}} while ({});
				]], { i(1, ""), i(2, "condition") })),
				s("trycatch", fmt([[
					try {{
						{}
					}} catch ({}) {{
						{}
					}}
				]], { i(1, ""), i(2, "err"), i(3, "") })),
				s("settimeout", fmt([[
					setTimeout(() => {{
						{}
					}}, {});"
				]], { i(1, ""), i(2, "timeout") })),
				s("setinterval", fmt([[
					setInterval(() => {{
						{}
					}}, {});"
				]], { i(1, ""), i(2, "timeout") })),
				s("imp", fmt([[
					import {} from '{}';
				]], { i(1, "item"), i(2, "lib") })),
			})
		end

		for _, lang in ipairs({ "typescriptreact", "javascriptreact" }) do
			ls.add_snippets(lang, {
				s("us", fmt("const [var, set{}] = useState({});", {
					i(1, "Var"),
					i(1, "")
				})),
				s("ue", fmt([[
					useEffect(()=> {{
						{}
					}},[{}])
					]],
					{ i(1, ""), i(2, "") })),
			})
		end
	end
}
