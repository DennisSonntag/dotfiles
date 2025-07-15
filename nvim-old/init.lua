--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NOTE: nixCats: this is where we define some arguments for the lazy wrapper.
local pluginList = nil
local nixLazyPath = nil
if require("nixCatsUtils").isNixCats then
	local allPlugins = require("nixCats").pawsible.allPlugins
	-- it is called pluginList because we only need to pass in the names
	-- this list literally just tells lazy.nvim not to download the plugins in the list.
	pluginList = require("nixCatsUtils.lazyCat").mergePluginTables(allPlugins.start, allPlugins.opt)

	-- it wasnt detecting that these were already added
	-- because the names are slightly different from the url.
	-- when that happens, add them to the list, then also specify the new name in the lazySpec
	pluginList[ [[Comment.nvim]] ] = ""
	pluginList[ [[blink.nvim]] ] = ""
	pluginList[ [[LuaSnip]] ] = ""
	-- alternatively you can do it all in the plugins spec instead of modifying this list.
	-- just set the name and then add `dev = require('nixCatsUtils').lazyAdd(false, true)` to the spec

	-- HINT: to view the names of all plugins downloaded via nix, use the `:NixCats pawsible` command.

	-- we also want to pass in lazy.nvim's path
	-- so that the wrapper can add it to the runtime path
	-- as the normal lazy installation instructions dictate
	nixLazyPath = allPlugins.start[ [[lazy.nvim]] ]
end
-- NOTE: nixCats: You might want to move the lazy-lock.json file
local function getlockfilepath()
	if require("nixCatsUtils").isNixCats and type(require("nixCats").settings.unwrappedCfgPath) == "string" then
		return require("nixCats").settings.unwrappedCfgPath .. "/lazy-lock.json"
	else
		return vim.fn.stdpath("config") .. "/lazy-lock.json"
	end
end

local icons = require("config.icons")

local lazyOptions = {
	lockfile = getlockfilepath(),

	-- install = { colorscheme = { 'tokyonight' } },
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"rplugin",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"editorconfig",
				"tohtml",
				-- "tutor",
				"zipPlugin",
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

require("nixCatsUtils.lazyCat").setup(pluginList, nixLazyPath, {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- { 'numToStr/Comment.nvim', name = 'comment.nvim', opts = {} },
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"andymass/vim-matchup",
		init = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"mawkler/modicator.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			show_warnings = false,
			highlights = {
				defaults = {
					bold = true,
					italic = false,
				},
			},
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		opts = {
			filetypes = { "*" },
			user_default_options = {
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				AARRGGBB = true, -- 0xAARRGGBB hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				tailwind = true, -- Enable tailwind colors
				sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
				always_update = true,
			},
			buftypes = {},
		},
	},
	{
		"stevearc/oil.nvim",
		opts = {
			skip_confirm_for_simple_edits = true,
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
		},
		keys = { {
			"-",
			function()
				require("oil").open()
			end,
		} },
	},
	{
		"okuuva/auto-save.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
		lazy = true,
	},
	{ "glacambre/firenvim", build = ":call firenvim#install(0)" },
	{
		"jinh0/eyeliner.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			highlight_on_key = true,
		},
	},

	{ import = "plugins" },
}, lazyOptions)

require("config.init")
vim.cmd.colorscheme("tokyonight")
