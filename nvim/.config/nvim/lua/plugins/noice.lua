return {
	"folke/noice.nvim",
	dependencies = { 'MunifTanjim/nui.nvim' },
	config = function()
		local status, noice = pcall(require, "noice")
		if (not status) then return end

		noice.setup({
			popupmenu = {
				enabled = true,
				backend = "cmp", -- backend to use to show regular cmdline completions
			}
		})
	end,
}
