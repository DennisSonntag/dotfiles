return {
	"goolord/alpha-nvim",
	lazy = false,
	opts = function()
		local icons = require("config.icons")
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[ ▄▄▌  ▄▄▄ . ▄▄ • ▄• ▄▌• ▌ ▄ ·. ▄▄▄ .]],
			[[██•  ▀▄.▀·▐█ ▀ ▪█▪██▌·██ ▐███▪▀▄.▀· ]],
			[[██ ▪ ▐▀▀▪▄▄█ ▀█▄█▌▐█▌▐█ ▌▐▌▐█·▐▀▀▪▄ ]],
			[[▐█▌ ▄▐█▄▄▌▐█▄▪▐█▐█▄█▌██ ██▌▐█▌▐█▄▄▌ ]],
			[[.▀▀▀  ▀▀▀ ·▀▀▀▀  ▀▀▀ ▀▀  █▪▀▀▀ ▀▀▀  ]],
			[[         __   __ _                  ]],
			[[         \ \ / /(_) _ __            ]],
			[[          \   / | || '  \           ]],
			[[           \_/  |_||_|_|_|          ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", icons.file.new .. " New file", "<cmd>ene <BAR> startinsert <CR>"),
			dashboard.button("e", icons.folder.closed .. " File tree", "<cmd>Neotree toggle float<CR>"),
			dashboard.button("f", icons.file.find .. " Find file",
				"<cmd>lua require('telescope.builtin').find_files({ hidden = true })<CR>"),
			dashboard.button("l", icons.extra.sleep .. " Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("m", icons.extra.settings .. " Mason", "<cmd>Mason<CR>"),
			dashboard.button("q", icons.extra.exit .. " Quit", "<cmd>qa<CR>"),
		}

		dashboard.section.footer.val = icons.extra.bean .. "NEVER LEND OR BORROW A MANS LEGUMES" .. icons.extra.bean
		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true
		return dashboard.opts
	end,
}
