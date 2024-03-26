local keymap = vim.keymap.set

-- Arrow keys are for plebs
keymap("n", "<Left>", "<Nop>")
keymap("n", "<Down>", "<Nop>")
keymap("n", "<Up>", "<Nop>") keymap("n", "<Right>", "<Nop>")

-- Toggle Spelling
keymap("n", "<leader>ts", function()
	vim.opt.spell = not (vim.opt.spell:get())
end)

--Centering shizzzzzzzzz
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "G", "Gzz")

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
