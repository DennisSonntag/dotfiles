return {
	"MunifTanjim/prettier.nvim",
	event = { 'BufRead *.tsx', 'BufRead *.jsx', 'BufRead *.js', 'BufRead *.ts', 'BufRead *.css', 'BufRead *.css' },
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
