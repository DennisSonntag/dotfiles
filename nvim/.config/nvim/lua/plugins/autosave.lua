return {
	"Pocco81/auto-save.nvim",
	event = 'BufRead',
	config = function()
		local auto_save_status, auto_save = pcall(require, "auto-save")
		if (not auto_save_status) then return end

		auto_save.setup()
	end
}
