return {
	"Pocco81/auto-save.nvim",
	event = 'BufRead',
	config = function()
		local status, auto_save = pcall(require, "auto-save")
		if (not status) then return end

		auto_save.setup()
	end
}
