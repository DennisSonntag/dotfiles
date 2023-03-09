return {
	"MunifTanjim/prettier.nvim",
	event = { 'BufRead *.tsx', 'BufRead *.jsx', 'BufRead *.js', 'BufRead *.ts', 'BufRead *.css' , 'BufRead *.css' },
	config = function()
		local status, prettier = pcall(require, "prettier")
		if (not status) then return end

		prettier.setup {
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
	end
}
