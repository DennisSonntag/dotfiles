return {
	"luukvbaal/statuscol.nvim",
	event = "BufRead",
	opts = function()
		local icons = require("config.icons")
		local signs = {
			Error = icons.diagnostics.error,
			Warn = icons.diagnostics.warn,
			Hint = icons.diagnostics.hint,
			Info = icons.diagnostics.info
		}



		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		return {
			segments = {
				{ text = { "%s" } },
				{
					text = { function(args)
						if args.relnum == 0 then
							if args.lnum == 69 then
								return "nice"
							elseif args.lnum == 420 then
								return "blaze"
							else
								return args.lnum
							end
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
