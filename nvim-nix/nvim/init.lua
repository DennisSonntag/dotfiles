-- print("HELLO WORLD")
vim.loader.enable()

local cmd = vim.cmd
-- local opt = vim.o

-- <leader> key. Defaults to `\`. Some people prefer space.
-- The default leader is '\'. Some people prefer <space>. Uncomment this if you do, too.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- See :h <option> to see what the options do

-- Search down into subfolders

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
-- cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
-- vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
