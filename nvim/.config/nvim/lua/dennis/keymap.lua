local keymap = vim.keymap.set

-- Arrow keys are for plebs
keymap("n", "<Left>", "<Nop>")
keymap("n", "<Down>", "<Nop>")
keymap("n", "<Up>", "<Nop>")
keymap("n", "<Right>", "<Nop>")

--File tree
-- Define a global variable to track whether netrw is open
vim.g.NetrwIsOpen = false

-- Define a function to toggle netrw
function ToggleNetrw()
	if vim.g.NetrwIsOpen then
		local i = vim.fn.bufnr("$")
		while i >= 1 do
			if vim.fn.getbufvar(i, "&filetype") == "netrw" then
				vim.cmd("bwipeout " .. i)
			end
			i = i - 1
		end
		vim.g.NetrwIsOpen = false
	else
		vim.g.NetrwIsOpen = true
		-- vim.cmd("Lexplore")
		vim.cmd("Lexplore")
	end
end

-- Define a global variable to track whether netrw is open
vim.g.NetrwIsOpen = false

-- Define a function to toggle netrw
function ToggleNetrw()
  if vim.g.NetrwIsOpen then
    local i = vim.fn.bufnr("$")
    while i >= 1 do
      if vim.fn.getbufvar(i, "&filetype") == "netrw" then
        vim.cmd("bwipeout " .. i)
      end
      i = i - 1
    end
    vim.g.NetrwIsOpen = false
  else
    vim.g.NetrwIsOpen = true
    vim.cmd("ex")
  end
end

-- Map a key to toggle netrw
vim.api.nvim_set_keymap("n", "<C-E>", ":lua ToggleNetrw()<CR>", { silent = true })


-- Map a key to toggle netrw
keymap("n", "<leader>pv", ToggleNetrw)



-- window shmovment
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")


-- Toggle Spelling
keymap("n", "<leader>ts", function()
	vim.opt.spell = not (vim.opt.spell:get())
end)

-- Tmux go brrrrrrrrrrrrrr
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer-tmux<CR>")

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
keymap("n", "<C-q>", "<cmd>q<CR>")

--Replace hovering word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<C-s>", [[:%s/\(.*\)/\1]])

--Git
keymap("n", "<leader>gl", function()
	vim.cmd.Git('log --graph --oneline --decorate')
end)

keymap("n", "<leader>ga", function()
	vim.cmd.Git('add .')
end)

keymap("n", "<leader>gc", function()
	vim.cmd.Git('commit')
end)

-- Split stufff
keymap("n", "<leader>sv", "<cmd>vsplit<CR>")
keymap("n", "<leader>sh", "<cmd>split<CR>")
keymap("n", "<leader>se", "<C-w>=")
keymap("n", "<leader>ss", "<C-w>R")
keymap("n", "<leader>stv", "<C-w>t<C-w>H")
keymap("n", "<leader>sth", "<C-w>t<C-w>K")

keymap("n", "<A-Left>", "3 0 <C-w>>")
keymap("n", "<A-Right>", "3 0 <C-w><")
keymap("n", "<A-Down>", "3 0 <C-w>-")
keymap("n", "<A-Up>", "3 0 <C-w>+")
