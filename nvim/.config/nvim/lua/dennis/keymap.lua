local keymap = vim.keymap.set

keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- keymap("v", "J", ":m '>+1<CR>gv=gv")
-- keymap("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "G", "Gzz")

--Open LazyGit
keymap('n', '<leader>g', ':FloatermNew --height=0.95 --width=0.95 lazygit<CR>')



-- Toggle Spelling
keymap("n", "<leader>ts", function()
	vim.opt.spell = not (vim.opt.spell:get())
end)

--Enable/Disable Codeium
keymap("n", "<leader>ce", function()
	vim.cmd("Codeium Enable")
end)

keymap("n", "<leader>cd", function()
	vim.cmd("Codeium Disable")
end)


--Keep current seach centerd
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "<C-w>", function() require('bufdelete').bufwipeout() end)

keymap("n", "<leader>e", "<cmd>Neotree toggle float<CR>")
keymap("n", "<leader>fg", " <cmd>Telescope live_grep<CR>")
keymap("n", "<leader>fb", " <cmd>Telescope buffers<CR>")
keymap("n", "<leader>fh", " <cmd>Telescope help_tags<CR>")


keymap("n", "<leader>lf", function() vim.lsp.buf.format() end)


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

--Folds
-- keymap("n", "<A-f>", function() require('fold-cycle').toggle_all() end)

-- Splits
keymap('n', '<A-h>', require('smart-splits').resize_left)
keymap('n', '<A-j>', require('smart-splits').resize_down)
keymap('n', '<A-k>', require('smart-splits').resize_up)
keymap('n', '<A-l>', require('smart-splits').resize_right)

keymap("n", "<leader>sv", "<cmd>vsplit<CR>")
keymap("n", "<leader>sh", "<cmd>split<CR>")
keymap("n", "<leader>se", "<C-w>=")
keymap("n", "<leader>ss", "<C-w>R")
keymap("n", "<leader>stv", "<C-w>t<C-w>H")
keymap("n", "<leader>sth", "<C-w>t<C-w>K")
keymap("n", "<leader>sm", function() require('maximize').toggle() end)

-- keymap("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
