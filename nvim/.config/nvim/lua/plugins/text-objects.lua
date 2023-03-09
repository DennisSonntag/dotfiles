return {
	"chrisgrieser/nvim-various-textobjs",
	event = 'BufRead',
	config = function()
		local status, textobjs = pcall(require, "various-textobjs")
		if (not status) then return end

		textobjs.setup({ useDefaultKeymaps = true })
		vim.keymap.set({ "o", "x" }, "as", function() textobjs.subword(false) end)
		vim.keymap.set({ "o", "x" }, "is", function() textobjs.subword(true) end)
	end
}
