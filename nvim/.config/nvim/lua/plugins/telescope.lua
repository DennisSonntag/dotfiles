return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local status, builtin = pcall(require, "telescope.builtin")
		if (not status) then return end

		vim.keymap.set('n', '<C-p>', function() builtin.git_files({ hidden = true }) end)
		vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ hidden = true }) end)

		vim.keymap.set("n", "<leader>fg", " <cmd>Telescope live_grep<CR>")
		vim.keymap.set("n", "<leader>fb", " <cmd>Telescope buffers<CR>")
		vim.keymap.set("n", "<leader>fh", " <cmd>Telescope help_tags<CR>")

		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") });
		end)

		local status2, telescope = pcall(require, "telescope")
		if (not status2) then return end

		telescope.setup {
			defaults = {
				mappings = {
					i = {
							["<C-k>"] = "move_selection_previous",
							["<C-j>"] = "move_selection_next",
							["<esc>"] = require('telescope.actions').close,
					}
				}
			},
		}
	end
}
