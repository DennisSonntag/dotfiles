vim.loader.enable()

local cmd = vim.cmd
local opt = vim.o

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


vim.cmd.colorscheme("tokyonight")

-- Native plugins
-- cmd.filetype('plugin', 'indent', 'on')
-- cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

