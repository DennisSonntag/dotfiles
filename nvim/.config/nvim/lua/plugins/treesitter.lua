return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"p00f/nvim-ts-rainbow",
		"windwp/nvim-ts-autotag"
	},
	build = ":TSUpdate",
	config = function()
		require('nvim-ts-autotag').setup()

		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			autotag = {
				enable = true,
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			rainbow = {
				enable = true,
				disable = { "html" },
				extended_mode = true,
				max_file_lines = nil,
				colors = {
					"#179FFF",
					"#EBC703",
					"#C768C3"
				},
			},
			indent = { enable = true },
		})
	end
}
