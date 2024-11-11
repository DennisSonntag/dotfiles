return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = require('nixCatsUtils').lazyAdd ':TSUpdate',
  opts = {
    -- NOTE: nixCats: use lazyAdd to only set these 2 options if nix wasnt involved.
    -- because nix already ensured they were installed.
    ensure_installed = require('nixCatsUtils').lazyAdd { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
    auto_install = require('nixCatsUtils').lazyAdd(true, false),

    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}

-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	build = ":TSUpdate",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	dependencies = {
-- 			"windwp/nvim-ts-autotag",
-- 			event = "InsertEnter",
-- 			config = true,
-- 	},
-- 	main = "nvim-treesitter.configs",
-- 	opts = {
-- 		ensure_installed = {
-- 			"astro",
-- 			"javascript",
-- 			"typescript",
-- 			"lua",
-- 			"c",
-- 			"cpp",
-- 			"css",
-- 			"json",
-- 			"bash",
-- 			"rust",
-- 			"html",
-- 			"java",
-- 			"prisma",
-- 			"python",
-- 			"dockerfile",
-- 			"tsx",
-- 			"make",
-- 			"markdown",
-- 			"markdown_inline",
-- 			"vim",
-- 			"yaml",
-- 			"toml",
-- 			"fish",
-- 			"comment",
-- 			"wgsl",
-- 			"wgsl_bevy",
-- 			"yuck",
-- 			"regex",
-- 			"svelte",
-- 		},
--
-- 		-- Autoinstall languages that are not installed
-- 		auto_install = true,
-- 		autotag = {
-- 			enable = true,
-- 		},
--
-- 		highlight = {
-- 			enable = true,
-- 			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
-- 			--  If you are experiencing weird indenting issues, add the language to
-- 			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
-- 			additional_vim_regex_highlighting = { "ruby" },
-- 		},
-- 		indent = { enable = true, disable = { "ruby" } },
-- 	},
-- }
--