return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin_status, builtin = pcall(require, "telescope.builtin")
		if (not builtin_status) then return end

		local telescope_status, telescope = pcall(require, "telescope")
		if (not telescope_status) then return end

		local actions_status, actions = pcall(require, "telescope.actions")
		if (not actions_status) then return end


		local keymap = vim.keymap.set

		keymap('n', '<C-p>', function() builtin.git_files({ hidden = true }) end)
		-- keymap('n', 'F', function() builtin.find_files({ hidden = true }) end)
		keymap('n', '<leader>ff', function() builtin.find_files({ hidden = true }) end)

		keymap("n", "<leader>fg", " <cmd>Telescope live_grep<CR>")
		keymap("n", "<leader>fb", " <cmd>Telescope buffers<CR>")
		keymap("n", "<leader>fh", " <cmd>Telescope help_tags<CR>")
		keymap("n", "<leader>fs", " <cmd>Telescope spell_suggest<CR>")

		telescope.setup({
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
		})
	end
}
