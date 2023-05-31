return {
	"nvim-treesitter/nvim-treesitter",
	event = 'BufRead',
	lazy = false,
	priority = 1000,
	dependencies = {
		"p00f/nvim-ts-rainbow",
		{ "windwp/nvim-ts-autotag", config = true }
	},
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "javascript", "typescript", "lua", "c", "cpp",
			"css", "json", "bash", "rust", "html", "java", "prisma", "python", "dockerfile", "toml", "tsx", "make",
			"markdown", "markdown_inline", "vim", "yaml", "toml", "fish", "astro", "comment", "wgsl", "wgsl_bevy" },
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
	},
	config = function(_, opts)
		vim.filetype.add({ extension = { wgsl = "wgsl" } })

		local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
		parser_config.wgsl = {
			install_info = {
				url = "https://github.com/szebniok/tree-sitter-wgsl",
				files = { "src/parser.c" }
			},
		}

		require("nvim-treesitter.configs").setup(opts)
	end
}
