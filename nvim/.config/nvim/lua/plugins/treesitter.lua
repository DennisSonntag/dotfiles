return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"p00f/nvim-ts-rainbow",
		"windwp/nvim-ts-autotag"
	},
	build = ":TSUpdate",
	config = function()
		local status, auto_tag = pcall(require, "nvim-ts-autotag")
		if (not status) then return end

		auto_tag.setup()

		local status2, treesitter = pcall(require, "nvim-treesitter.configs")
		if (not status2) then return end

		treesitter.setup({
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
