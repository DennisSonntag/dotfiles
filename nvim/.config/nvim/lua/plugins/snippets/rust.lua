local ls_status, ls = pcall(require, "luasnip")
if not ls_status then
	return
end

local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	{
		s("print", fmt('print!("{}");', { i(1) })),
	},
	{
		s("println", fmt('println!("{}");', { i(1) })),
	},
	{
		s("format", fmt('format!("{}");', { i(1) })),
	},
	s("if",
		fmta([[
if <condition> {
	<code>
}
]], { condition = i(1), code = i(2) })),
	s("if-let",
		fmta([[
if let <name> = <expr> {
	<code>
}
]], { name = i(1), expr = i(2), code = i(3) })),
	s("for",
		fmta([[
for <val> in <list> {
	<code>
}
]], { val = i(1), list = i(2), code = i(3) })),

	s("struct",
		fmta([[
struct <name> {
	<vals>
}
]], { name = i(1), vals = i(2) })),

	s("enum",
		fmta([[
enum <name> {
	<vals>
}
]], { name = i(1), vals = i(2) })),
}
