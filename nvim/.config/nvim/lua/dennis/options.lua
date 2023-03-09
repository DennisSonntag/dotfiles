local o = vim.opt
local g = vim.g

o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.relativenumber = true
o.termguicolors = true
o.errorbells = false
-- g.mapleader = " "
o.smartindent = true
o.cursorline = true
-- o.cursorcolumn = true
o.splitbelow = true
o.cmdheight = 0
o.splitright = true
o.timeoutlen = 1000
o.incsearch = true
o.showtabline = 0
o.swapfile = false
o.hlsearch = false
o.undofile = true o.updatetime = 50
o.softtabstop = 4
o.shiftwidth = 4
o.backup = false
o.hidden = true
o.wrap = false
o.tabstop = 4
o.mouse = "a"
o.nu = true

--Spelling
vim.opt.spelllang = { 'en_us' }
