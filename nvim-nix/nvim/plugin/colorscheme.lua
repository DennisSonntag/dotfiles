local status, tokyonight = pcall(require, 'tokyonight')
if not status then
  return
end

tokyonight.setup({
  style = "storm",
  transparent = true,
  dim_inactive = true, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
  on_highlights = function(hl, colors)
    hl.MatchParen = { bg = "#3b4261" }
    hl.BqfPreviewFloat = { bg = colors.bg }
    hl.Pmenu = { bg = "#2d3349" }
    hl.CmpDocumentation = { bg = "#2d3349" }
    hl.PmenuSel = { bg = "#404866" }
    hl.CursorLine = {
      bg = "#2d3349",
      bold = true,
    }
    -- For Modicator
    hl.CursorLineNr = {
      fg = "#388bfd",
      bg = "NONE",
    }
  end,
})

vim.cmd.colorscheme("tokyonight")
