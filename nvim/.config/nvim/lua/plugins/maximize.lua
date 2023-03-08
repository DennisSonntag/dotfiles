return {
	"declancm/maximize.nvim",
	config = function()
		local status, maximize = pcall(require, "maximize")
		if (not status) then return end

		maximize.setup()
	end
}
