local status, smart_splits = pcall(require, 'smart-splits')
if not status then
  return
end

local keymap = vim.keymap.set

smart_splits.setup({
  ignored_filetypes = {
    "nofile",
    "quickfix",
    "prompt",
    "neo-tree",
  },
  at_edge = "wrap",
})

-- window shmovment
keymap("n", "<C-h>", function() smart_splits.move_cursor_left()end)
keymap("n", "<C-j>", function() smart_splits.move_cursor_down()end)
keymap("n", "<C-k>", function() smart_splits.move_cursor_up()end)
keymap("n", "<C-l>", function() smart_splits.move_cursor_right()end)

-- window resizing
keymap("n", "<A-Left>",function() smart_splits.resize_left()end)
keymap("n", "<A-Down>",function() smart_splits.resize_down()end)
keymap("n", "<A-Up>",function() smart_splits.resize_up()end)
keymap("n", "<A-Right>",function() smart_splits.resize_right()end)

-- swapping splits
keymap("n", "<leader><leader>h", function() smart_splits.swap_buf_left()end)
keymap("n", "<leader><leader>j", function() smart_splits.swap_buf_down()end)
keymap("n", "<leader><leader>k", function() smart_splits.swap_buf_up()end)
keymap("n", "<leader><leader>l", function() smart_splits.swap_buf_right()end)

-- creating splits
keymap("n", "<leader>sv", "<cmd>vsplit<CR>")
keymap("n", "<leader>sh", "<cmd>split<CR>")

-- managing splits
keymap("n", "<leader>se", "<C-w>=")
keymap("n", "<leader>ss", "<C-w>R")
keymap("n", "<leader>stv", "<C-w>t<C-w>H")
keymap("n", "<leader>sth", "<C-w>t<C-w>K")
