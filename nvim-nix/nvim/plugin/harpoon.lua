local status, harpoon = pcall(require, 'harpoon')
if not status then
  return
end

harpoon.setup({})

local ui_status, ui = pcall(require, 'harpoon.ui')
if not ui_status then
return
end

local mark_staus, mark = pcall(require, 'harpoon.mark')
if not mark_staus then
return
end

local function mark_file()
mark.add_file()
vim.notify '󱡅  marked file'
end

local keymap = vim.keymap.set

keymap("n", "<leader>a", mark_file)
keymap("n", "<C-e>", ui.toggle_quick_menu)

keymap("n", "<A-1>", function() ui.nav_file(1) end)
keymap("n", "<A-2>", function() ui.nav_file(2) end)
keymap("n", "<A-3>", function() ui.nav_file(3) end)
keymap("n", "<A-4>", function() ui.nav_file(4) end)
keymap("n", "<A-5>", function() ui.nav_file(5) end)
