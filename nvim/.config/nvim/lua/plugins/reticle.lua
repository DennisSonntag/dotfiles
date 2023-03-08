return {
	"Tummetott/reticle.nvim",
	config = function()
		local status, reticle = pcall(require, "reticle")
		if (not status) then return end

		reticle.setup()
	end
}
