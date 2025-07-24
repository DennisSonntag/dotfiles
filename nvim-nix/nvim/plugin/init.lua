local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'VimEnter' }, {
  callback = function()
    local status_todo, todo = pcall(require, 'todo-comments')
    if not status_todo then
      return
    end

    todo.setup { signs = false }
  end,
})

-- vim.g.matchup_matchparen_offscreen = { method = "popup" }

autocmd({ 'BufReadPre', 'BufNewFile' }, {
  callback = function()
    local status_modicator, modicator = pcall(require, 'modicator')
    if not status_modicator then
      return
    end

    modicator.setup {
      show_warnings = false,
      highlights = {
        defaults = {
          bold = true,
          italic = false,
        },
      },
    }
  end,
})

autocmd({ 'BufRead' }, {
  callback = function()
    local status_colorizer, colorizer = pcall(require, 'colorizer')
    if not status_colorizer then
      return
    end

    colorizer.setup {
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
    }
  end,
})

local status_oil, oil = pcall(require, 'oil')
if not status_oil then
  return
end

oil.setup {
  skip_confirm_for_simple_edits = true,
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
}

vim.keymap.set('n', '-', function()
  require('oil').open()
end)

--
-- {
-- 	"okuuva/auto-save.nvim",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	config = true,
-- 	lazy = true,
-- },
--
-- {
-- 	"jinh0/eyeliner.nvim",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	opts = {
-- 		highlight_on_key = true,
-- 	},
-- },
-- {
-- 	"utilyre/sentiment.nvim",
-- 	event = { "BufReadPre", "BufNewFile", "BufRead" },
-- 	config = function()
-- 		vim.g.loaded_matchparen = 1 -- `matchparen.vim` needs to be disabled manually in case of lazy loading
-- 	end,
-- },
-- }
