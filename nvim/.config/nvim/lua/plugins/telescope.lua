return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local status, builtin = pcall(require, "telescope.builtin")
		if (not status) then return end

		local keymap = vim.keymap.set

		keymap('n', '<C-p>', function() builtin.git_files({ hidden = true }) end)
		keymap('n', 'F', function() builtin.find_files({ hidden = true }) end)
		keymap("n", "<leader>fw", "<cmd>Telescope tailiscope<cr>")

		keymap("n", "<leader>fg", " <cmd>Telescope live_grep<CR>")
		keymap("n", "<leader>fb", " <cmd>Telescope buffers<CR>")
		keymap("n", "<leader>fh", " <cmd>Telescope help_tags<CR>")
		keymap("n", "<leader>fs", " <cmd>Telescope spell_suggest<CR>")

		local status2, telescope = pcall(require, "telescope")
		if (not status2) then return end

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = "move_selection_previous",
						["<C-j>"] = "move_selection_next",
						["<esc>"] = require('telescope.actions').close,
					}
				}
			},
		})
	end
}
