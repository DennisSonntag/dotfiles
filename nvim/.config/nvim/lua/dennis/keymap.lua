local keymap = vim.keymap.set

keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "G", "Gzz")

--Open LazyGit
keymap('n', '<leader>g', ':FloatermNew --height=0.95 --width=0.95 lazygit<CR>')

-- Toggle Spelling
keymap("n", "<leader>ts", function()
	vim.opt.spell = not (vim.opt.spell:get())
end)

--Keep current seach centerd
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- greatest remap ever
keymap("x", "<leader>p", [["_dP]])

-- "Capital Q is the worst place in the universe"-ThePrimeagen
keymap("n", "Q", "<nop>")


-- next greatest remap ever : asbjornHaland
keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])


--Quite
keymap("n", "<C-q>", "<cmd>q<CR>")

--Replace hovering word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap("n", "<leader>sv", "<cmd>vsplit<CR>")
keymap("n", "<leader>sh", "<cmd>split<CR>")
keymap("n", "<leader>se", "<C-w>=")
keymap("n", "<leader>ss", "<C-w>R")
keymap("n", "<leader>stv", "<C-w>t<C-w>H")
keymap("n", "<leader>sth", "<C-w>t<C-w>K")
