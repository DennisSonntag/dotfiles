return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local tokyonight_status, tokyonight = pcall(require, "tokyonight")
			if (not tokyonight_status) then return end

			tokyonight.setup({
				style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = true,
				styles = {
					sidebars = "transparent", -- style for sidebars, see below
					floats = "transparent", -- style for floating windows
				},
			})

			vim.cmd.colorscheme("tokyonight")

			vim.api.nvim_set_hl(0, "MatchParen", {
				bg = "#3b4261",
			})

		end
	},


}
