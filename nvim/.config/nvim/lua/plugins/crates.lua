return {
	"saecki/crates.nvim",
	ft = { "rust", "toml" },
	opts = {
		src = {
			coq = {
				enabled = true,
				name = "Crates",
			},
		},
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		}
	}
}
