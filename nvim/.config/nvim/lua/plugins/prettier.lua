return {
	"MunifTanjim/prettier.nvim",
	event = "BufRead",
	ft = { "tsx", "jsx", "js", "ts", "css", "css" },
	opts = {
		bin = "prettierd",
		filetypes = {
			"css",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"json",
			"scss",
			"less"
		}
	}
}
