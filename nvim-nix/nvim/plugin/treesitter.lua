local status, configs = pcall(require, 'nvim-treesitter.configs')
if not status then
	return
end
-- require("nvim-treesitter.install").prefer_git = true
---@diagnostic disable-next-line: missing-fields

---@diagnostic disable-next-line: missing-fields
configs.setup({ -- ensure_installed = 'all',
  -- auto_install = false, -- Do not automatically install missing parsers when entering buffer
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KiB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
})

--
-- configs.setup({
-- 	-- NOTE: nixCats: use lazyAdd to only set these 2 options if nix wasnt involved.
-- 	-- because nix already ensured they were installed.
-- 	ensure_installed = {
-- 		"bash",
-- 		"c",
-- 		"diff",
-- 		"html",
-- 		"lua",
-- 		"luadoc",
-- 		"markdown",
-- 		"vim",
-- 		"vimdoc",
-- 	},
-- 	auto_install = true,
--
-- 	highlight = {
-- 		enable = true,
-- 		-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
-- 		--  If you are experiencing weird indenting issues, add the language to
-- 		--  the list of additional_vim_regex_highlighting and disabled languages for indent.
-- 		additional_vim_regex_highlighting = { "ruby" },
-- 	},
-- 	indent = { enable = true, disable = { "ruby" } },
-- })
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
