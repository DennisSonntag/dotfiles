return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-telescope/telescope-ui-select.nvim",
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local icons = require("config.icons")
		local builtin = require("telescope.builtin")

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		require("telescope").setup({
			defaults = {
				prompt_prefix = icons.ui.Telescope .. " ",
				selection_caret = icons.ui.Forward .. " ",
				entry_prefix = "   ",
				initial_mode = "insert",
				selection_strategy = "reset",
				path_display = { "smart" },
				color_devicons = true,
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/",
				},
			},
			pickers = {
				live_grep = {
					theme = "dropdown",
				},

				grep_string = {
					theme = "dropdown",
				},

				find_files = {
					theme = "dropdown",
					previewer = false,
				},

				buffers = {
					theme = "dropdown",
					previewer = false,
					initial_mode = "normal",
				},

				planets = {
					show_pluto = true,
					show_moon = true,
				},

				colorscheme = {
					enable_preview = true,
				},

				lsp_references = {
					theme = "dropdown",
					initial_mode = "normal",
				},

				lsp_definitions = {
					theme = "dropdown",
					initial_mode = "normal",
				},

				lsp_declarations = {
					theme = "dropdown",
					initial_mode = "normal",
				},

				lsp_implementations = {
					theme = "dropdown",
					initial_mode = "normal",
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,    -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
		vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "[F]ind [S]pelling" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
		vim.keymap.set("n",
			"<leader>/",
			function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 0,
					previewer = false,
				}))
			end,
			{ desc = "[/] Fuzzily search in current buffer" })
		vim.keymap.set("n",
			"<leader>s/",
			function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end,
			{ desc = "[S]earch [/] in Open Files" })
		vim.keymap.set("n",
			"<leader>sn",
			function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end,
			{ desc = "[S]earch [N]eovim files" })
	end,
}
