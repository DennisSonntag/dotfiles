return {
	"folke/noice.nvim",
	dependencies = { 'MunifTanjim/nui.nvim' },
	config = function()
		require("noice").setup({
			popupmenu = {
				enabled = true,
				backend = "cmp", -- backend to use to show regular cmdline completions
			}
		})
	end,
}
