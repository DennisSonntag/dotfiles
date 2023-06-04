return {
	"utilyre/sentiment.nvim",
	event = "VeryLazy", -- keep for lazy loading
	config = true,
	init = function()
		-- `matchparen.vim` needs to be disabled manually in case of lazy loading
		vim.g.loaded_matchparen = 1
	end,
}

