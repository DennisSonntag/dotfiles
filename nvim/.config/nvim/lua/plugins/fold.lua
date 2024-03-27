return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		local keymap = vim.keymap.set

		require("ufo").setup {
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰡏 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end,
			open_fold_hl_timeout = 0,
			enable_get_fold_virt_text = false,
			close_fold_kinds_for_ft = {},
			provider_selector = function(bufnr, filetype, buftype)
				local ftMap = {
					default = { "lsp", "treesitter" },
					python = { "indent" },
					git = "",
				}
				return ftMap[filetype]
			end,

			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:Folded",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-k>",
					scrollD = "<C-j>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
		}

		keymap("n", "zR", require("ufo").openAllFolds)
		keymap("n", "zM", require("ufo").closeAllFolds)
		keymap("n", "zr", require("ufo").openFoldsExceptKinds)
		keymap("n", "zm", require("ufo").closeFoldsWith)
		keymap("n", "zk", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end)
	end

}
