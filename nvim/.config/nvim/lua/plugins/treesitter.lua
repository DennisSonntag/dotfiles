return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	priority = 1000,
	dependencies = {
		"nvim-treesitter/playground",
		{
			"nvim-treesitter/nvim-treesitter-context",
			keys = { { "<leader>tc", "<cmd>TSContextToggle<Cr>" } },
			opts = {
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
				trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			}
		},
		{ "windwp/nvim-ts-autotag", config = true }
	},
	build = ":TSUpdate",
	opts =
		function()
			return {
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
				ensure_installed = { "astro", "javascript", "typescript", "lua", "c", "cpp", "css", "json", "bash",
					"rust", "html", "java", "prisma", "python", "dockerfile", "toml", "tsx", "make", "markdown",
					"markdown_inline", "vim", "yaml", "toml", "fish", "comment", "wgsl", "wgsl_bevy", "yuck" },
				autotag = {
					enable = true,
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = true },

			}
		end,
	main = "nvim-treesitter.configs",
	init = function()
		vim.filetype.add({ extension = { wgsl = "wgsl" } })

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.wgsl = {
			install_info = {
				url = "https://github.com/szebniok/tree-sitter-wgsl",
				files = { "src/parser.c" }
			},
		}
	end
}
