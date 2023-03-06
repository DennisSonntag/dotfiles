return {
	"L3MON4D3/LuaSnip",
	config = function()
		vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
		local ls = require("luasnip")

		ls.snippets = {
			all = {

			},
			lua = {

			}
		}
	end
}
