return {
	"utilyre/barbecue.nvim",
	event = 'BufRead',
	dependencies = {
		"SmiteshP/nvim-navic",
	},
	opts = function()
		local icons = require("config.icons")

		return {
			theme = 'tokyonight',
			symbols = {
				modified = icons.file.modified,
				ellipsis = "…",
				separator = icons.folder.collapsed,
			},
			kinds = {
				Text = icons.kinds.Text,
				Method = icons.kinds.Method,
				Function = icons.kinds.Function,
				Constructor = icons.kinds.Constructor,
				Field = icons.kinds.Field,
				Variable = icons.kinds.Variable,
				Class = icons.kinds.Class,
				Interface = icons.kinds.Interface,
				Module = icons.kinds.Module,
				Property = icons.kinds.Property,
				Unit = icons.kinds.Unit,
				Value = icons.kinds.Value,
				Enum = icons.kinds.Enum,
				Keyword = icons.kinds.Keyword,
				Snippet = icons.kinds.Snippet,
				Color = icons.kinds.Color,
				File = icons.kinds.File,
				Reference = icons.kinds.Reference,
				Folder = icons.kinds.Folder,
				EnumMember = icons.kinds.EnumMember,
				Constant = icons.kinds.Constant,
				Struct = icons.kinds.Struct,
				Event = icons.kinds.Event,
				Operator = icons.kinds.Operator,
				TypeParameter = icons.kinds.TypeParameter,
				Object = icons.kinds.Object,
			}
		}
	end
}
