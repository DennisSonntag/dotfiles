local o = vim.opt
local g = vim.g

g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_show_icons = 1
-- g.WebDevIconsUnicodeDecorateFolderNodes = 1
-- g.WebDevIconsUnicodeDecorateFileNodes = 1
-- g.WebDevIconsUnicodeGlyphDoubleWidth = 1



o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
o.swapfile = false
o.backup = false

o.scrolloff = 8
o.sidescrolloff = 8

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
o.spelllang = { 'en_us' }
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

