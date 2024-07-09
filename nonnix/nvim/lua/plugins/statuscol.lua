return {
	"luukvbaal/statuscol.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = function()
		local builtin = require("statuscol.builtin")
		return {
			setopt = true,
			relculright = true,
			segments = {
				{
					text = {
						function(args)
							args.fold.sep = " "
							args.fold.close = ""
							args.fold.open = ""
							return builtin.foldfunc(args)
						end,
						" ",
					},
					click = "v:lua.ScFa",
					hl = "Comment",
				},

				{ text = { "%s" }, click = "v:lua.ScSa" },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
			},
		}
	end,
}
