return {
	"mrjones2014/smart-splits.nvim",
	main = "smart-splits",
	keys = function()
		local split_status, smart_splits = pcall(require, "smart-splits")
		if not split_status then return end

		return {
			-- window shmovment
			{ "<C-h>",             smart_splits.move_cursor_left },
			{ "<C-j>",             smart_splits.move_cursor_down },
			{ "<C-k>",             smart_splits.move_cursor_up },
			{ "<C-l>",             smart_splits.move_cursor_right },

			-- window resizing
			{ "<A-Left>",          smart_splits.resize_left },
			{ "<A-Down>",          smart_splits.resize_down },
			{ "<A-Up>",            smart_splits.resize_up },
			{ "<A-Right>",         smart_splits.resize_right },

			-- swapping splits
			{ "<leader><leader>h", smart_splits.swap_buf_left },
			{ "<leader><leader>j", smart_splits.swap_buf_down },
			{ "<leader><leader>k", smart_splits.swap_buf_up },
			{ "<leader><leader>l", smart_splits.swap_buf_right },

			-- creating splits
			{ "<leader>sv",        "<cmd>vsplit<CR>" },
			{ "<leader>sh",        "<cmd>split<CR>" },

			-- managing splits
			{ "<leader>se",        "<C-w>=" },
			{ "<leader>ss",        "<C-w>R" },
			{ "<leader>stv",       "<C-w>t<C-w>H" },
			{ "<leader>sth",       "<C-w>t<C-w>K" },
		}
	end,
	opts = {
		ignored_filetypes = {
			"nofile",
			"quickfix",
			"prompt",
			"neo-tree"
		},
		at_edge = "wrap",
	}

}
