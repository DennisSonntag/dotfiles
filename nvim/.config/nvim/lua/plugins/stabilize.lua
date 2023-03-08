return {
	"luukvbaal/stabilize.nvim",
	config = function()
		local status, stabilize = pcall(require, "stabilize")
		if (not status) then return end

		stabilize.setup()
	end
}
