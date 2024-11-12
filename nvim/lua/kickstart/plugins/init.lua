-- NOTE: nixCats: instead of uncommenting them, you can enable them
-- from the categories set in your packageDefinitions in your flake or other template!
-- This is because within them, we used nixCats to check if it should be loaded!
require 'kickstart.plugins.autopairs'
require 'kickstart.plugins.cmp'
require 'kickstart.plugins.colorscheme'
require 'kickstart.plugins.debug'
require 'kickstart.plugins.fold'
require 'kickstart.plugins.git'
require 'kickstart.plugins.harpoon'
require 'kickstart.plugins.indent_line'
require 'kickstart.plugins.lsp'
require 'kickstart.plugins.lualine'
require 'kickstart.plugins.luasnip'
require 'kickstart.plugins.mini'
require 'kickstart.plugins.quickfix'
require 'kickstart.plugins.rainbow'
require 'kickstart.plugins.smart-splits'
require 'kickstart.plugins.statuscol'
require 'kickstart.plugins.telescope'
require 'kickstart.plugins.treesitter'

return {
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'andymass/vim-matchup',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },
  {
    'mawkler/modicator.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
    'NvChad/nvim-colorizer.lua',
    event = 'BufRead',
    opts = {
      filetypes = { '*' },
      user_default_options = {
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        tailwind = true, -- Enable tailwind colors
        sass = { enable = true, parsers = { 'css' } }, -- Enable sass colors
        always_update = true,
      },
      buftypes = {},
    },
  },
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
    },
    keys = { {
      '-',
      function()
        require('oil').open()
      end,
    } },
  },
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  {
    'okuuva/auto-save.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
    lazy = true,
  },

  {
    'jinh0/eyeliner.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      highlight_on_key = true,
    },
  },
  {
    'utilyre/sentiment.nvim',
    event = { 'BufReadPre', 'BufNewFile', 'BufRead' },
    config = function()
      vim.g.loaded_matchparen = 1 -- `matchparen.vim` needs to be disabled manually in case of lazy loading
    end,
  },
}
