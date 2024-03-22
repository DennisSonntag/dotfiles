return {
	"kevinhwang91/nvim-ufo",
	event = "BufRead",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		vim.o.foldcolumn = '1'
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

		require('ufo').setup({
			provider_selector = function(_bufnr, _filetype, _buftype)
				return { 'lsp', 'indent' }
			end
		})
	end
}
