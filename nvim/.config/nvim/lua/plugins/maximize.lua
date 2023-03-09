return {
	"declancm/maximize.nvim",
	config = function()
		local status, maximize = pcall(require, "maximize")
		if (not status) then return end

		maximize.setup()

		vim.keymap.set("n", "<leader>sm", function() maximize.toggle() end)
	end
}
