return {
	"nvim-telescope/telescope.nvim",
	opts = function()
		local actions_status, actions = pcall(require, "telescope.actions")
		if (not actions_status) then return end

		return {
			defaults = {
				layout_config = {
					horizontal = {
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.95,
					height = 0.95,
					preview_cutoff = 120,
				},
				winblend = 0,
				mappings = {
					i = {
						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
						["<esc>"] = actions.close,
					}
				}
			},
		}
	end,
	config = function(_, opts)
		require("telescope").setup(opts)
	end,
	keys = {
		{ '<C-p>',      function() require("telescope.builtin").git_files({ hidden = true }) end },
		{ '<leader>ff', function() require("telescope.builtin").find_files({ hidden = true }) end },
		{ "<leader>fg", " <cmd>Telescope live_grep<CR>" },
		{ "<leader>fb", " <cmd>Telescope buffers<CR>" },
		{ "<leader>fh", " <cmd>Telescope help_tags<CR>" },
		{ "<leader>fs", " <cmd>Telescope spell_suggest<CR>" },
	}
}
