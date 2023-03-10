return {
	"utilyre/barbecue.nvim",
	event = 'BufRead',
	dependencies = {
		"SmiteshP/nvim-navic",
	},
	config = function()
		local status, barbecue = pcall(require, "barbecue")
		if (not status) then return end

		barbecue.setup({
				---whether to show/use navic in the winbar
				---@type boolean
				show_navic = true,
				---whether to attach navic to language servers automatically
				---@type boolean
				attach_navic = true,
				---whether to create winbar updater autocmd
				---@type boolean
				create_autocmd = true,
				---buftypes to enable winbar in
				---@type string[]
				include_buftypes = { "" },
				---filetypes not to enable winbar in
				---@type string[]
				exclude_filetypes = { "gitcommit", "toggleterm" },
				modifiers = {
					---filename modifiers applied to dirname
					---@type string
					dirname = ":~:.",
					---filename modifiers applied to basename
					---@type string
					basename = "",
				},
				---returns a string to be shown at the end of winbar
				---@type fun(bufnr: number): string
				custom_section = function() return "" end,
				---`auto` uses your current colorscheme's theme or generates a theme based on it
				---`string` is the theme name to be used (theme should be located under `barbecue.theme` module)
				---`barbecue.Theme` is a table that overrides the `auto` theme detection/generation
				---@type "auto"|string|barbecue.Theme
				-- theme = "auto",
				theme = 'tokyonight',
				---whether to replace file icon with the modified symbol when buffer is modified
				---@type boolean
				show_modified = false,
				symbols = {
					---modification indicator
					---@type string
					modified = "●",
					---truncation indicator
					---@type string
					ellipsis = "…",
					---entry separator
					---@type string
					separator = "",
				},
				---icons for different context entry kinds
				---`false` to disable kind icons
				---@type table<string, string>|false
				kinds = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "ﰠ",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					Operator = "",
					TypeParameter = "",
					Object = "",
				}
			})
	end
}
