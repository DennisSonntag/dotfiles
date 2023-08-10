local o = vim.opt

vim.g.inlaytoggle = false
vim.g.rustinlaytoggle = false


o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.swapfile = false
o.backup = false

o.scrolloff = 8
o.sidescrolloff = 8

o.completeopt = "menu,menuone,noselect"

o.smartindent = true
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4
o.copyindent = true

o.relativenumber = true
o.nu = true

o.signcolumn = "yes"
o.cursorline = true

o.fillchars = { eob = " " }
o.spelllang = { "en_us" }
o.termguicolors = true
o.errorbells = false

o.splitbelow = true
o.splitright = true

o.incsearch = true
o.hlsearch = false

o.timeoutlen = 1000
o.updatetime = 50

o.showtabline = 0
o.cmdheight = 1
o.hidden = true
o.wrap = false
o.mouse = "a"
