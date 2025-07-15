local keymap = vim.keymap.set

-- Arrow keys are for plebs
keymap("n", "<Left>", "<Nop>")
keymap("n", "<Down>", "<Nop>")
keymap("n", "<Up>", "<Nop>")
keymap("n", "<Right>", "<Nop>")

-- Toggle Spelling
keymap("n", "<leader>ts", function()
	vim.opt.spell = not (vim.opt.spell:get())
end)

-- Toggle diagnostics

vim.api.nvim_create_user_command("ToggleDiagnostics", function()
	if vim.g.diagnostics_enabled == nil then
		vim.g.diagnostics_enabled = false
		vim.diagnostic.disable()
	elseif vim.g.diagnostics_enabled then
		vim.g.diagnostics_enabled = false
		vim.diagnostic.disable()
	else
		vim.g.diagnostics_enabled = true
		vim.diagnostic.enable()
	end
end, {})

keymap("n", "<leader>ltd", "<cmd>ToggleDiagnostics<CR>")

--Centering shizzzzzzzzz
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "gg", "ggzz")
keymap("n", "G", "Gzz")
keymap("n", "{", "{zz")
keymap("n", "}", "}zz")
keymap("n", "<C-i>", "<C-i>zz")
keymap("n", "<C-o>", "<C-o>zz")
-- keymap("n", "%", "%zz")
-- keymap("n", "*", "*zz")
-- keymap("n", "#", "#zz")

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
-- TODO: Remove this when switching to colemake mod dh and dactyl manuform
keymap({ "n", "v" }, "L", "$")
keymap({ "n", "v" }, "H", "^")

-- greatest remap ever
keymap("x", "<leader>p", [["_dP]])

-- "Capital Q is the worst place in the universe"-ThePrimeagen
keymap("n", "Q", "<nop>")

-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])

--Quit
keymap("n", "<C-Q>", "<cmd>qa<CR>")
keymap("n", "<C-q>", "<cmd>q<CR>")

--Replace hovering word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- keymap("n", "<C-s>", [[:%s/\(.*\)/\1]])

keymap("n", "<leader>;", "<cmd>GotoPos<CR>")

keymap({ "i", "s" }, "<Tab>", "<Tab>")
