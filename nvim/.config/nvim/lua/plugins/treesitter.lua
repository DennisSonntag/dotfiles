return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = { "windwp/nvim-ts-autotag", config = true },
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = { "astro", "javascript", "typescript", "lua", "c", "cpp", "css", "json", "bash",
			"rust", "html", "java", "prisma", "python", "dockerfile", "tsx", "make", "markdown",
			"markdown_inline", "vim", "yaml", "toml", "fish", "comment", "wgsl", "wgsl_bevy", "yuck", "regex", "svelte" },

		-- Autoinstall languages that are not installed
		auto_install = true,
		autotag = {
			enable = true,
		},

		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	}
}
