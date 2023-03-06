return {
	'glepnir/lspsaga.nvim',
	event = 'BufRead',
	config = function()
		require('lspsaga').setup({
			symbol_in_winbar = {
				enable = false,
			},
			rename = {
				quit = '<Esc>',
				exec = '<CR>',
				mark = 'x',
				confirm = '<CR>',
				in_select = false,
				whole_project = true,
			},
			ui = {
				-- currently only round theme
				theme = 'round',
				-- border type can be single,double,rounded,solid,shadow.
				border = 'rounded',
				winblend = 0,
				expand = '',
				collapse = '',
				preview = ' ',
				code_action = '💡',
				diagnostic = '🐞',
				incoming = ' ',
				outgoing = ' ',
				colors = {
					--float window normal bakcground color
					normal_bg = '#14161f',
					--title background color
					title_bg = '#5DE4C2',

					red = '#e95678',
					magenta = '#b33076',

					-- orange = '#FF8700',
					orange = '#ffffff',

					yellow = '#f7bb3b',

					green = '#afd700',

					cyan = '#36d0e0',
					blue = '#61afef',
					purple = '#CBA6F7',
					white = '#d1d4cf',
					black = '#1c1c19',
				},
				kind = {},
			},
		})

		local keymap = vim.keymap.set

		local opts = { noremap = true, silent = true }
		keymap('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
		keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
		keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
		keymap('i', '<C-k>', function() vim.lsp.buf.signature_help() end, opts)
		keymap('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
		-- keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
		keymap('n', '<F2>', '<Cmd>Lspsaga rename<CR>', opts)
		keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
	end
}
