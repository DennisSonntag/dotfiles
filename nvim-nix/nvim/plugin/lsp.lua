require("fidget").setup()
-- TODO conform
-- TODO nvim-lint
--
			-- local servers = {}
			-- servers.clangd = {},
			-- servers.gopls = {},
			-- servers.pyright = {},
			-- servers.rust_analyzer = {},
			-- servers.tsserver = {}
			-- 	servers.nixd = {
			-- 		cmd = { "nixd" },
			-- 		settings = {
			-- 			nixd = {
			-- 				nixpkgs = {
			-- 					expr = "import <nixpkgs> {}",
			-- 				},
			-- 			},
			-- 			formatting = {
			-- 				command = { "alejandra" },
			-- 			},
			-- 		},
			-- 	}
			-- 	servers.rnix = {}
			-- 	servers.nil_ls = {}
			--
			--
			--
			--
			-- servers.svelte = {}
			-- servers.tailwindcss = {}
			-- servers.cssls = {}
			-- servers.jsonls = {}
			-- servers.ts_ls = {}
			-- servers.basedpyright = {}
			-- servers.html = {}
			-- servers.clangd = {
				-- root_dir = function(fname)
				-- 	return require("lspconfig.util").root_pattern(
				-- 		"Makefile",
				-- 		"configure.ac",
				-- 		"configure.in",
				-- 		"config.h.in",
				-- 		"meson.build",
				-- 		"meson_options.txt",
				-- 		"build.ninja"
				-- 	)(fname) or require("lspconfig.util").root_pattern(
				-- 		"compile_commands.json",
				-- 		"compile_flags.txt"
				-- 	)(fname) or require("lspconfig.util").find_git_ancestor(fname)
				-- end,
				-- capabilities = {
				-- 	offsetEncoding = { "utf-16" },
				-- },
				-- cmd = {
				-- 	"clangd",
					-- "--std=c23",
					-- 	"--background-index",
					-- 	"--clang-tidy",
					-- 	"--header-insertion=iwyu",
					-- 	"--completion-style=detailed",
					-- 	"--function-arg-placeholders",
					-- 	"--fallback-style=llvm",
				-- },
				-- init_options = {
				-- fallbackFlags = { "--std=c23" },
				-- 	usePlaceholders = true,
				-- 	completeUnimported = true,
				-- 	clangdFileStatus = true,
				-- },
			-- }























		local keymap = vim.keymap.set

		keymap("n", "<leader>lf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end)





		require("conform").setup({
			notify_on_error = false,
			-- format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				-- local disable_filetypes = { c = true, cpp = true }
				-- return {
					-- 	timeout_ms = 2500,
					-- 	lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					-- }
					-- end,
					formatters = {
						prettier = {
							prepend_args = { "--config", "~/.prettierrc" },
							-- The base args are { "-filename", "$FILENAME" } so the final args will be
							-- { "-i", "2", "-filename", "$FILENAME" }
						},
					},
					formatters_by_ft = {
						lua = { "stylua" },
						-- Conform can also run multiple formatters sequentially
						-- python = { "isort", "black" },
						--
						-- You can use a sub-list to tell conform to run *until* a formatter
						-- is found.
						javascript = { "prettier" },
						typescript = { "prettier" },
						svelte = { "prettier" },
						json = { "prettier" },
						html = { "prettier" },
						css = { "prettier" },
						nix = { "alejandra" },
						cpp = { "clang-format" },
						c = { "clang-format" },
						glsl = { "clang-format" },
						vert = { "clang-format" },
						frag = { "clang-format" },
					},
				})

