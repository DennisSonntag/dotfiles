local o = vim.opt

vim.g.rustinlaytoggle = false

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "resize" }

o.list = false -- Don't show invisible characters (tabs...

o.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
o.undofile = true
o.swapfile = false
o.backup = false

o.scrolloff = 8
o.sidescrolloff = 8

o.completeopt = "menu,menuone,noselect"

if vim.fn.has("nvim-0.10") == 1 then
	o.smoothscroll = true
end

-- Ident/Tabs
o.autoindent = true
o.cindent = true
o.smartindent = true
o.softtabstop = 4
o.softtabstop = 4
o.expandtab = false
o.tabstop = 4
o.copyindent = true

-- Line Numbers
o.relativenumber = true
o.nu = true

o.signcolumn = "yes"
o.cursorline = true

o.showmode = false -- Dont show mode since we have a statusline
o.fillchars = { eob = " " }
o.spelllang = { "en" }
o.spell = false
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
-- o.mouse = "a"

--- folds
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.emmet_show_expand_abbreviation = "never"
