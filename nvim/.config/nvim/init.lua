--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local icons = require("config.icons")

require('lazy').setup {
	spec = {
		{ import = 'plugins' },
	},
	defaults = {
		lazy = false, -- TODO: change this to true later
	},
	install = { colorscheme = { 'tokyonight' } },
	debug = false,
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				'gzip',
				'matchit',
				'matchparen',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'tutor',
				'zipPlugin',
			},
		},
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	ui = {
		border = "rounded",
		icons = {
			cmd = icons.ui.cmd,
			config = icons.extra.settings,
			event = icons.extra.event,
			ft = icons.folder.closed,
			init = icons.extra.settings,
			keys = icons.extra.keys,
			plugin = icons.extra.plug,
			runtime = icons.extra.runtime,
			require = icons.extra.require,
			source = icons.file.file,
			start = icons.extra.start,
			task = icons.extra.task,
			lazy = icons.extra.lazy,
		},
	},
}

require 'config'
