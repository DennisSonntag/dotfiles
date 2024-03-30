return {
	"goolord/alpha-nvim",
	enabled = false,
	dependencies = {
		"MaximilianLloyd/ascii.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = function()
		local icons = require("config.icons")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = require("ascii").get_random_global()

		dashboard.section.buttons.val = {
			dashboard.button("n", icons.file.new .. " New file", "<cmd>ene <BAR> startinsert <CR>"),
			dashboard.button("f", icons.file.find .. " Find file", '<cmd>lua require("telescope.builtin").find_files({ hidden = true })<CR>'),
			dashboard.button("l", icons.extra.sleep .. " Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("m", icons.extra.settings .. " Mason", "<cmd>Mason<CR>"),
			dashboard.button("q", icons.extra.exit .. " Quit", "<cmd>qa<CR>"),
		}

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true

		local file = io.open(vim.fn.stdpath("config") .. "/quotes.txt", "r")
		if not file then
			return
		end
		local lines = {}

		for line in file:lines() do
			table.insert(lines, line)
		end

		file:close()

		local randomQuote = lines[math.random(#lines)]
		dashboard.section.footer.val = randomQuote

		return dashboard.opts
	end,
}
