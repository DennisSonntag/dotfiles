return {
	"declancm/maximize.nvim",
	event = 'WinEnter',
	config = function()
		local status, maximize = pcall(require, "maximize")
		if (not status) then return end

		maximize.setup()

		vim.keymap.set("n", "<leader>sm", maximize.toggle)
	end
}
