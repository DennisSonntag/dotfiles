return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local status, tokyonight = pcall(require, "tokyonight")
		if (not status) then return end

		tokyonight.setup({

			style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
			transparent = true,
			styles = {
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "transparent", -- style for sidebars, see below
				floats = "transparent", -- style for floating windows
			},
		})

		vim.cmd("colorscheme tokyonight")
	end
}
