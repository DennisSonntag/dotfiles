return {
	"L3MON4D3/LuaSnip",
	dependencies = { "hrsh7th/nvim-cmp" },
	event = "InsertEnter",
	config = function()
		local ls_status, ls = pcall(require, "luasnip")
		if (not ls_status) then return end

		require("luasnip.loaders.from_lua").load({paths = vim.fn.stdpath("config") .. "lua/plugins/snippets"})

		require("luasnip").config.setup({ store_selection_keys = "<A-p>" })

		vim.cmd("command! LuaSnipEdit :lua requre('luasnip.loaders.from_lua').edit_snippet_files()")

		-- Virtual Text
		local types = require("luasnip.util.types")
		ls.config.set_config({
			history = true,                   --> keep around last snippet local to jump back
			updateevents = "TextChanged,TextChangedI", --> update changes as you type
			enable_autosnippets = true,
			ext_opts = {
				[types.choiceNode] = {
					active = {
						virt_text = { { "●", "GruvboxOrange" } },
					},
				},
			},
		})

		local s = ls.s
		local i = ls.i
		-- local t = ls.t

		-- local d = ls.dynamic_node
		-- local c = ls.choice_node
		local f = ls.function_node
		-- local sn = ls.snippet_node


		local fmt = require("luasnip.extras.fmt").fmt
		local rep = require("luasnip.extras").rep

		for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			ls.add_snippets(lang, {
				s("log", fmt("console.log({});", {
					i(1)
				})),
				s("af", fmt([[
					const {} = ({}) => {{
						{}
					}};
					]]
				, {
					i(1, "name"),
					i(2, "param"),
					i(3),
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
					}}{}
				]], { i(1, "condition"), i(2), i(3) })),
				s("elif", fmt([[
					else if ({}) {{
						{}
					}}{}
				]], { i(1, "condition"), i(2), i(3) })),
				s("else", fmt([[
					else {{
						{}
					}}
				]], { i(1) })),
				s("while", fmt([[
					while ({}) {{
						{}
					}}
				]], { i(1, "condition"), i(2) })),
				s("dowhile", fmt([[
					do {{
						{}
					}} while ({});
				]], { i(1), i(2, "condition") })),
				s("trycatch", fmt([[
					try {{
						{}
					}} catch ({}) {{
						{}
					}}
				]], { i(1), i(2, "err"), i(3) })),
				s("settimeout", fmt([[
					setTimeout(() => {{
						{}
					}}, {});"
				]], { i(1), i(2, "timeout") })),
				s("setinterval", fmt([[
					setInterval(() => {{
						{}
					}}, {});"
				]], { i(1), i(2, "timeout") })),
				s("imp", fmt([[
					import {} from "{}";
				]], { i(1, "item"), i(2, "lib") })),
				s("case", fmt([[
					case {}:
						{}
						break;
				]], { i(1), i(2) })),
				s("switch", fmt([[
					switch ({}) {{
						case {}:
						{}
						break;
						default:
						{}
						break;
					}}
				]], { i(1), i(2), i(3), i(4) })),
			})
		end
		ls.add_snippets("typescriptreact", {
			s("comp", fmt([[
				import type {{ FC }} from "react";

				type PropTypes = {{
					{}: {};
				}};

				const {}: FC<PropTypes> = ({{ {} }}) => {{
					return (
						{}
					);
				}};

				export default {};
			]]
			, {
				i(1, "prop"),
				i(2, "type"),
				i(3, "Component"),
				rep(1),
				i(4),
				rep(3)
			})),
		})

		local sameCap = function(index)
			return f(function(arg)
				local input = arg[1][1]
				return input:sub(1, 1):upper() .. input:sub(2)
			end, { index })
		end

		for _, lang in ipairs({ "typescriptreact", "javascriptreact" }) do
			ls.add_snippets(lang, {
				s("us", fmt("const [{}, set{}] = useState({});", {
					i(1, "var"),
					sameCap(1), -- Pass an empty string to the returned function
					i(2)
				})),
				s("class", fmt("className=\"{}\"", {
					i(1)
				})),
				s("ref", fmt("const {} = useRef({});", {
					i(1, "refName"),
					i(2, "null")
				})),
				s("ue", fmt([[
					useEffect(()=> {{
						{}
					}},[{}])
					]],
					{ i(1), i(2) })),
			})
		end

		for _, lang in ipairs({ "typescriptreact", "javascriptreact", "html", "astro", "svelte" }) do
			ls.add_snippets(lang, {
				s("doctype",
					fmt("<!DOCTYPE>{}", { i(1), })),

				s("a",
					fmt("<a href=\"{}\">{}</a>{}", { i(1), i(2), i(3), })),

				s("abbr",
					fmt("<abbr title=\"{}\">{}</abbr>{}", { i(1), i(2), i(3), })),

				s("address",
					fmt("<address>{}</address>", { i(1), })),

				s("area",
					fmt("<area shape=\"{}\" coords=\"{}\" href=\"{}\" alt=\"{}\">{}", { i(1), i(2), i(3), i(4), i(5), })),
				s("article",
					fmt("<article>{}</article>", { i(1), })),

				s("aside",
					fmt("<aside>{}</aside>{}", { i(1), i(2), })),

				s("audio",
					fmt("<audio controls>\t{}</audio>", { i(1), })),

				s("b",
					fmt("<b>{}</b>{}", { i(1), i(2), })),

				s("base",
					fmt("<base href=\"{}\" target=\"{}\">{}", { i(1), i(2), i(3), })),

				s("bdi",
					fmt("<bdi>{}</bdi>{}", { i(1), i(2), })),

				s("bdo",
					fmt("<bdo dir=\"{}\">{}</bdo>", { i(1), i(2), })),

				s("big",
					fmt("<big>{}</big>{}", { i(1), i(2), })),

				s("blockquote",
					fmt("<blockquote cite=\"{}\">\t{}</blockquote>", { i(1), i(2), })),

				s("body",
					fmt("<body>\t{}</body>", { i(1), })),

				s("br",
					fmt("<br>", {})),

				s("button",
					fmt("<button type=\"{}\">{}</button>{}", { i(1), i(2), i(3), })),

				s("canvas",
					fmt("<canvas id=\"{}\">{}</canvas>{}", { i(1), i(2), i(3), })),

				s("caption",
					fmt("<caption>{}</caption>{}", { i(1), i(2), })),

				s("cite",
					fmt("<cite>{}</cite>{}", { i(1), i(2), })),

				s("code",
					fmt("<code>{}</code>{}", { i(1), i(2), })),

				s("col",
					fmt("<col>{}", { i(1), })),

				s("colgroup",
					fmt("<colgroup>\t{}</colgroup>", { i(1), })),

				s("command",
					fmt("<command>{}</command>{}", { i(1), i(2), })),

				s("datalist",
					fmt("<datalist>{}</datalist>", { i(1), })),

				s("dd",
					fmt("<dd>{}</dd>{}", { i(1), i(2), })),

				s("del",
					fmt("<del>{}</del>{}", { i(1), i(2), })),

				s("details",
					fmt("<details>{}</details>", { i(1), })),

				s("dialog",
					fmt("<dialog>{}</dialog>{}", { i(1), i(2), })),

				s("dfn",
					fmt("<dfn>{}</dfn>{}", { i(1), i(2), })),

				s("div",
					fmt("<div>{}</div>", { i(1), })),

				s("dl",
					fmt("<dl>{}</dl>", { i(1), })),

				s("dt",
					fmt("<dt>{}</dt>{}", { i(1), i(2), })),

				s("em",
					fmt("<em>{}</em>{}", { i(1), i(2), })),

				s("embed",
					fmt("<embed src=\"{}\">{}", { i(1), i(2), })),

				s("fieldset",
					fmt("<fieldset>{}</fieldset>", { i(1), })),

				s("figcaption",
					fmt("<figcaption>{}</figcaption>{}", { i(1), i(2), })),

				s("figure",
					fmt("<figure>{}</figure>", { i(1), })),

				s("footer",
					fmt("<footer>{}</footer>", { i(1), })),

				s("form",
					fmt("<form>{}</form>", { i(1), })),

				s("h1",
					fmt("<h1>{}</h1>{}", { i(1), i(2), })),

				s("h2",
					fmt("<h2>{}</h2>{}", { i(1), i(2), })),

				s("h3",
					fmt("<h3>{}</h3>{}", { i(1), i(2), })),

				s("h4",
					fmt("<h4>{}</h4>{}", { i(1), i(2), })),

				s("h5",
					fmt("<h5>{}</h5>{}", { i(1), i(2), })),

				s("h6",
					fmt("<h6>{}</h6>{}", { i(1), i(2), })),

				s("head",
					fmt("<head>{}</head>", { i(1), })),

				s("header",
					fmt("<header>{}</header>", { i(1), })),

				s("hgroup",
					fmt("<hgroup>{}</hgroup>", { i(1), })),

				s("hr",
					fmt("<hr>", {})),

				s("html",
					fmt("<html>{}</html>", { i(1), })),

				s("!", fmt([[
						<!DOCTYPE html>
						<html lang="us-en">
							<head>
								<title>{}</title>
								<meta charset="UTF-8">
								<meta name="viewport" content="width=device-width, initial-scale=1">
							</head>
							<body>
								{}
							</body>
						</html>
					]], { i(1), i(2) })),

				s("i",
					fmt("<i>{}</i>{}", { i(1), i(2), })),

				s("iframe",
					fmt("<iframe src=\"{}\">{}</iframe>{}", { i(1), i(2), i(3), })),

				s("img",
					fmt("<img src=\"{}\" alt=\"{}\">{}", { i(1), i(2), i(3), })),

				s("input",
					fmt("<input type=\"{}\" name=\"{}\" value=\"{}\">{}", { i(1), i(2), i(3), i(4), })),

				s("ins",
					fmt("<ins>{}</ins>{}", { i(1), i(2), })),

				s("keygen",
					fmt("<keygen name=\"{}\">{}", { i(1), i(2), })),

				s("kbd",
					fmt("<kbd>{}</kbd>{}", { i(1), i(2), })),

				s("label",
					fmt("<label for=\"{}\">{}</label>{}", { i(1), i(2), i(3), })),

				s("legend",
					fmt("<legend>{}</legend>{}", { i(1), i(2), })),

				s("li",
					fmt("<li>{}</li>{}", { i(1), i(2), })),

				s("link",
					fmt("<link rel=\"{}\" type=\"{}\" href=\"{}\">{}", { i(1), i(2), i(3), i(4), })),

				s("link:css",
					fmt("<link rel=\"stylesheet\" type=\"text/css\" href=\"{}.css\">", { i(1) })),

				s("main",
					fmt("<main>{}</main>", { i(1), })),

				s("map",
					fmt("<map name=\"{}\">{}</map>", { i(1), i(2), })),

				s("mark",
					fmt("<mark>{}</mark>{}", { i(1), i(2), })),

				s("menu",
					fmt("<menu>{}</menu>", { i(1), })),

				s("menuitem",
					fmt("<menuitem>{}</menuitem>{}", { i(1), i(2), })),

				s("meta",
					fmt("<meta name=\"{}\" content=\"{}\">{}", { i(1), i(2), i(3), })),

				s("meter",
					fmt("<meter value=\"{}\">{}</meter>{}", { i(1), i(2), i(3), })),

				s("nav",
					fmt("<nav>{}</nav>", { i(1), })),

				s("noscript",
					fmt("<noscript>{}</noscript>", { i(1), })),

				s("object",
					fmt("<object width=\"{}\" height=\"{}\" data=\"{}\">{}</object>{}", { i(1), i(2), i(3), i(4), i(5), })),
				s("ol",
					fmt("<ol>{}</ol>", { i(1), })),

				s("optgroup",
					fmt("<optgroup>{}</optgroup>", { i(1), })),

				s("option",
					fmt("<option value=\"{}\">{}</option>{}", { i(1), i(2), i(3), })),

				s("output",
					fmt("<output name=\"{}\" for=\"{}\">{}</output>{}", { i(1), i(2), i(3), i(4), })),

				s("p",
					fmt("<p>{}</p>{}", { i(1), i(2), })),

				s("param",
					fmt("<param name=\"{}\" value=\"{}\">{}", { i(1), i(2), i(3), })),

				s("pre",
					fmt("<pre>{}</pre>", { i(1), })),

				s("progress",
					fmt("<progress value=\"{}\" max=\"{}\">{}</progress>{}", { i(1), i(2), i(3), i(4), })),

				s("q",
					fmt("<q>{}</q>{}", { i(1), i(2), })),

				s("rp",
					fmt("<rp>{}</rp>{}", { i(1), i(2), })),

				s("rt",
					fmt("<rt>{}</rt>{}", { i(1), i(2), })),

				s("ruby",
					fmt("<ruby>{}</ruby>", { i(1), })),

				s("s",
					fmt("<s>{}</s>{}", { i(1), i(2), })),

				s("samp",
					fmt("<samp>{}</samp>{}", { i(1), i(2), })),

				s("script",
					fmt("<script>{}</script>", { i(1), })),

				s("script:src",
					fmt("<script defer src=\"{}\"></script>", { i(1), })),

				s("section",
					fmt("<section>{}</section>", { i(1), })),

				s("select",
					fmt("<select>{}</select>", { i(1), })),

				s("small",
					fmt("<small>{}</small>{}", { i(1), i(2), })),

				s("source",
					fmt("<source src=\"{}\" type=\"{}\">{}", { i(1), i(2), i(3), })),

				s("span",
					fmt("<span>{}</span>{}", { i(1), i(2), })),

				s("strong",
					fmt("<strong>{}</strong>{}", { i(1), i(2), })),

				s("style",
					fmt("<style>{}</style>", { i(1), })),

				s("sub",
					fmt("<sub>{}</sub>{}", { i(1), i(2), })),

				s("sup",
					fmt("<sup>{}</sup>{}", { i(1), i(2), })),

				s("summary",
					fmt("<summary>{}</summary>{}", { i(1), i(2), })),

				s("table",
					fmt("<table>{}</table>", { i(1), })),

				s("tbody",
					fmt("<tbody>{}</tbody>", { i(1), })),

				s("td",
					fmt("<td>{}</td>{}", { i(1), i(2), })),

				s("textarea",
					fmt("<textarea rows=\"{}\" cols=\"{}\">{}</textarea>{}", { i(1), i(2), i(3), i(4), })),

				s("tfoot",
					fmt("<tfoot>{}</tfoot>", { i(1), })),

				s("thead",
					fmt("<thead>{}</thead>", { i(1), })),

				s("th",
					fmt("<th>{}</th>{}", { i(1), i(2), })),

				s("time",
					fmt("<time datetime=\"{}\">{}</time>{}", { i(1), i(2), i(3), })),

				s("title",
					fmt("<title>{}</title>{}", { i(1), i(2), })),

				s("tr",
					fmt("<tr>{}</tr>{}", { i(1), i(2), })),

				s("track",
					fmt("<track src=\"{}\" kind=\"{}\" srclang=\"{}\" label=\"{}\">{}", { i(1), i(2), i(3), i(4), i(5), })),
				s("u",
					fmt("<u>{}</u>{}", { i(1), i(2), })),

				s("ul",
					fmt("<ul>{}</ul>", { i(1), })),

				s("var",
					fmt("<var>{}</var>{}", { i(1), i(2), })),

				s("video",
					fmt("<video width=\"{}\" height=\"{}\" controls>{}</video>", { i(1), i(2), i(3), })),
			})
		end
	end
}
