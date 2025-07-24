local autocmd = vim.api.nvim_create_autocmd

local status, statuscol = pcall(require, 'statuscol')
if not status then
  return
end


autocmd({ "BufReadPre", "BufNewFile" }, {
	callback = function()
		local builtin = require 'statuscol.builtin'
		statuscol.setup({
			setopt = true,
			relculright = true,
			segments = {
				{
					text = {
						function(args)
							args.fold.sep = ' '
							args.fold.close = ''
							args.fold.open = ''
							return builtin.foldfunc(args)
						end,
						' ',
					},
					click = 'v:lua.ScFa',
					hl = 'Comment',
				},

				{ text = { '%s' }, click = 'v:lua.ScSa' },
				{ text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
			},
		})

	end,
})

