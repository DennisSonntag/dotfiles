return {
  'lukas-reineke/indent-blankline.nvim',
  event = 'BufRead',
  main = 'ibl',
  config = function()
    local highlight = {
      'RainbowRed',
      'RainbowYellow',
      'RainbowBlue',
      'RainbowOrange',
      'RainbowGreen',
      'RainbowViolet',
      'RainbowCyan',
    }
    local hooks = require 'ibl.hooks'

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
      vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
      vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
      vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
      vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
      vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
      vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }
    require('ibl').setup {
      scope = {
        highlight = highlight,
        enabled = true,
        char = '▎',
        include = {
          node_type = {
            lua = { 'return_statement', 'table_constructor', 'parameter', 'arguments' },
            typescript = {
              'return_statement',
              'table_constructor',
              'parameter',
              'arguments',
              'object_type',
              'type_alias_declaration',
              'switch_body',
            },
          },
        },
        priority = 500,
      },
      debounce = 100,
      indent = {
        char = '▎',
        tab_char = { '▎' },
      },
      viewport_buffer = {
        min = 0,
        max = 600,
      },
    }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
