return {
	"narutoxy/silicon.lua",
	config = function()
		local status, silicon = pcall(require, "silicon")
		if (not status) then return end

		silicon.setup({
			theme = "auto",
			output = "~/Pictures/nvimScreenshots/SILICON_${year}-${month}-${date}_${time}.png", -- auto generate file name based on time (absolute or relative to cwd)
			-- bgColor = vim.g.terminal_color_5,
			bgColor = "#14161f",
			bgImage = "", -- path to image, must be png
			roundCorner = true,
			windowControls = false,
			lineNumber = true,
			font = "monospace",
			lineOffset = 1, -- from where to start line number
			linePad = 2, -- padding between lines
			padHoriz = 10, -- Horizontal padding
			padVert = 10, -- vertical padding
			shadowBlurRadius = 10,
			shadowColor = "#555555",
			shadowOffsetX = 8,
			shadowOffsetY = 8,
			gobble = false, -- enable lsautogobble like feature
			debug = false, -- enable debug output
		})

		vim.keymap.set('v', '<leader>cc', function() silicon.visualise_api({}) end)
	end
}
