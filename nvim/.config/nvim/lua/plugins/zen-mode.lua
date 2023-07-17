return {
	"folke/zen-mode.nvim",
	cmd = "ZenMode",
	keys = {
		{ "<leader>z", "<cmd>ZenMode<CR>" }

	},
	opts = {
		window = {
			height = 0.9
		},
		plugins = {
			tmux = { enabled = true }, -- disables the tmux statusline
			gitsigns = { enabled = true }, -- disables git signs
		},
		on_open = function()
			require("barbecue.ui").toggle(false)
			vim.fn.system("kitty-zen-on")
		end,
		-- callback where you can add custom code when the Zen window closes
		on_close = function()
			require("barbecue.ui").toggle(true)
			vim.fn.system("kitty-zen-off")
		end,
	}
}
