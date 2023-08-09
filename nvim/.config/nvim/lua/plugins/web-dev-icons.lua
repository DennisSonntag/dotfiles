return {
	"nvim-tree/nvim-web-devicons",
	dependencies = { "nvim-neo-tree/neo-tree.nvim" },
	opts = {
		override_by_extension = {
			["rs"] = {
				icon = "󱘗 ",
				color = "#f77f00",
				name = "Rust"
			}
		}

	},
}
