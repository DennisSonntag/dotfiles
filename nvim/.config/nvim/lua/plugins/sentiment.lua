return {
	"utilyre/sentiment.nvim",
	event = "BufRead",
	config = true,
	init = function()
		vim.g.loaded_matchparen = 1 -- `matchparen.vim` needs to be disabled manually in case of lazy loading
	end,
}
