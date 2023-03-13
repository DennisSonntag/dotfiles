return {
	"chrisgrieser/nvim-various-textobjs",
	event = 'BufRead',
	config = function()
		local status, textobjs = pcall(require, "various-textobjs")
		if (not status) then return end


		local keymap = vim.keymap.set
		textobjs.setup({ useDefaultKeymaps = true })
		keymap({ "o", "x" }, "as", function() textobjs.subword(false) end)
		keymap({ "o", "x" }, "is", function() textobjs.subword(true) end)
	end
}
