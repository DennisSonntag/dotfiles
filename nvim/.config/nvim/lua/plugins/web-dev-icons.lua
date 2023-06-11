return {
	"nvim-tree/nvim-web-devicons",
	after = "neo-tree",
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
