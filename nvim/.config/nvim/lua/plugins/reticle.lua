return {
	"Tummetott/reticle.nvim",
	event = 'WinEnter',
	config = function()
		local status, reticle = pcall(require, "reticle")
		if (not status) then return end

		reticle.setup()
	end
}
