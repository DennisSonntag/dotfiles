return {
	"saecki/crates.nvim",
	event = 'BufRead',
	config = function()
			local crates_status, crates = pcall(require, "crates")
			if (not crates_status) then return end

			crates.setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				}
			})

	end
}
