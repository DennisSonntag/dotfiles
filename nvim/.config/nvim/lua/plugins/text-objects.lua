return {
	"chrisgrieser/nvim-various-textobjs",
	config = function () 
		require("various-textobjs").setup({ useDefaultKeymaps = true })
		vim.keymap.set({"o", "x"}, "as", function () require("various-textobjs").subword(false) end)
		vim.keymap.set({"o", "x"}, "is", function () require("various-textobjs").subword(true) end)


	end
}
