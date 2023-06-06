return {
	"luukvbaal/statuscol.nvim",
	event = 'BufRead',
	opts = function()
		local builtin = require("statuscol.builtin")
		local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

		for type, icon in pairs(signs) do
			local hl = 'DiagnosticSign' .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
		end

		return {
			segments = {
				{ text = { "%s" } },
				{
					text = { function(args)
						if args.relnum == 0 then
							return args.lnum
						else
							return args.relnum
						end
					end },
					click = "v:lua.ScLa",
				},
				{ text = { " " } },
			}
		}
	end,
}
