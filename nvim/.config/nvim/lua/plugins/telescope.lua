return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set('n', '<C-p>', function() builtin.git_files({ hidden = true }) end)
		vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ hidden = true }) end)

		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") });
		end)

		require("telescope").setup {
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
