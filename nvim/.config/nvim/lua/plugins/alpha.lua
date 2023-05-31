return {
	"goolord/alpha-nvim",
	opts = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			[[                                               _______  ________  ______  __    __                                                         ]],
			[[                                               |       \|        \/      \|  \  |  \                                                       ]],
			[[                                               | ▓▓▓▓▓▓▓\ ▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓\ ▓▓\ | ▓▓                                                       ]],
			[[                                               | ▓▓__/ ▓▓ ▓▓__   | ▓▓__| ▓▓ ▓▓▓\| ▓▓                                                       ]],
			[[                                               | ▓▓    ▓▓ ▓▓  \  | ▓▓    ▓▓ ▓▓▓▓\ ▓▓                                                       ]],
			[[                                               | ▓▓▓▓▓▓▓\ ▓▓▓▓▓  | ▓▓▓▓▓▓▓▓ ▓▓\▓▓ ▓▓                                                       ]],
			[[                                               | ▓▓__/ ▓▓ ▓▓_____| ▓▓  | ▓▓ ▓▓ \▓▓▓▓                                                       ]],
			[[                                               | ▓▓    ▓▓ ▓▓     \ ▓▓  | ▓▓ ▓▓  \▓▓▓                                                       ]],
			[[     ██████████                                 \▓▓▓▓▓▓▓ \▓▓▓▓▓▓▓▓\▓▓   \▓▓\▓▓   \▓▓                                       ███████████     ]],
			[[  ████████████████                                       __   __ _                                                      █████████████████  ]],
			[[███████████████████                                      \ \ / /(_) _ __                                               ███████████████████ ]],
			[[████████████████████                                      \   / | || '  \                                             ████████████████████ ]],
			[[██████████████████████                                     \_/  |_||_|_|_|                                          ██████████████████████ ]],
			[[ ████████████████████████████                                                                                ████████████████████████████  ]],
			[[  ███████████████████████████████                                                                        ███████████████████████████████   ]],
			[[    ███████████████████████████████                                                                    ███████████████████████████████     ]],
			[[      ██████████████████████████████                                                                   █████████████████████████████       ]],
			[[         ██████████████████████████                                                                    ██████████████████████████          ]],
			[[             █████████████████████                                                                       ████████████████████              ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "" .. " New file", "<cmd>ene <BAR> startinsert <CR>"),
			dashboard.button("e", "" .. " File tree", "<cmd>Neotree toggle float<CR>"),
			dashboard.button("f", "" .. " Find file", "<cmd>Telescope find_files <CR>"),
			dashboard.button("l", "" .. " Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("m", "" .. " Mason", "<cmd>Mason<CR>"),
			dashboard.button("q", "" .. " Quit", "<cmd>qa<CR>"),
		}

		dashboard.section.footer.val = "MORE BEANZZ ANYONE?!"
		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true
		return dashboard.opts
	end,
	config = function(_, opts)
		require("alpha").setup(opts)
	end
}
