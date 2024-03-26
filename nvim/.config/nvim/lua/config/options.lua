local o = vim.opt

vim.g.rustinlaytoggle = false

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "resize" }

o.list = true -- Show some invisible characters (tabs...

o.undodir = os.getenv "HOME" .. "/.vim/undodir"
o.undofile = true
o.swapfile = false
o.backup = false

o.scrolloff = 8
o.sidescrolloff = 8

o.completeopt = "menu,menuone,noselect"

if vim.fn.has("nvim-0.10") == 1 then
  o.smoothscroll = true
end

o.smartindent = true
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4
o.copyindent = true

o.relativenumber = true
o.nu = true

o.signcolumn = "yes"
o.cursorline = true

o.showmode = false -- Dont show mode since we have a statusline
o.fillchars = { eob = " " }
o.spelllang = { "en" }
o.spell = true
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
