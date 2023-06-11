return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	priority = 1000,
	dependencies = {
		-- "p00f/nvim-ts-rainbow",
		"HiPhish/nvim-ts-rainbow2",
		"nvim-treesitter/playground",
		{ "windwp/nvim-ts-autotag", config = true }
	},
	build = ":TSUpdate",
	opts =
		function()
			local rainbow = require("ts-rainbow")
			return {
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = 'o',
						toggle_hl_groups = 'i',
						toggle_injected_languages = 't',
						toggle_anonymous_nodes = 'a',
						toggle_language_display = 'I',
						focus_language = 'f',
						unfocus_language = 'F',
						update = 'R',
						goto_node = '<cr>',
						show_help = '?',
					},
				},
				ensure_installed = { "javascript", "typescript", "lua", "c", "cpp",
					"css", "json", "bash", "rust", "html", "java", "prisma", "python", "dockerfile", "toml", "tsx",
					"make",
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
					-- list of languages you want to disable the plugin for
					disable = { 'jsx', 'cpp' },
					-- Which query to use for finding delimiters
					query = 'rainbow-parens',
					-- Highlight the entire buffer all at once
					strategy = rainbow.strategy.global,
				},
				-- rainbow = {
				-- 	enable = true,
				-- 	disable = { "html" },
				-- 	extended_mode = true,
				-- 	max_file_lines = nil,
				-- 	colors = {
				-- 		"#179FFF",
				-- 		"#EBC703",
				-- 		"#C768C3"
				-- 	},
				-- },
				indent = { enable = true },

			}
		end,
	main = "nvim-treesitter.configs",
	init = function()
		vim.filetype.add({ extension = { wgsl = "wgsl" } })

		local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
		parser_config.wgsl = {
			install_info = {
				url = "https://github.com/szebniok/tree-sitter-wgsl",
				files = { "src/parser.c" }
			},
		}
	end
}
