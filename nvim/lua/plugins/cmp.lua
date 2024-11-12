return {
	"saghen/blink.cmp",
	lazy = false, -- lazy loading handled internally
	-- use a release tag to download pre-built binaries
	dependencies = "rafamadriz/friendly-snippets",
	-- version = false,
	version = "v0.*",
	-- build = 'nix run .#build-plugin',
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- keymap = { preset = 'super-tab' },

		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
			["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			["<C-y>"] = { "accept", "fallback" },
			-- ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			-- ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
		},
		sources = {
			providers = {
				buffer = {
					fallback_for = {},
				},
			},
		},
		documentation = {
			auto_show = false,
		},
		highlight = {
			-- sets the fallback highlight groups to nvim-cmp's highlight groups
			-- useful for when your theme doesn't support blink.cmp
			-- will be removed in a future release, assuming themes add support
			use_nvim_cmp_as_default = true,
		},
		-- experimental auto-brackets support
		accept = { auto_brackets = { enabled = true } },
		-- experimental signature help support
		trigger = { signature_help = { enabled = true } },
	},
}
