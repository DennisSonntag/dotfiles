return {
	"goolord/alpha-nvim",
	config = function()
		local status, alpha = pcall(require, "alpha")
		if (not status) then return end

		local dashboard = require "alpha.themes.dashboard"
		dashboard.section.header.val = {
            [[            ░░░░░░░▒▒▒▒▒▒▒▒▒      ░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓       ]],
            [[        ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒    ]],
            [[     ░░░░░░░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒   ]],
            [[    ░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒   ]],
            [[    ▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ]],
            [[     ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒   ]],
            [[      ▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓     ]],
            [[         ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓       ]],
            [[             ▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░        ]],
            [[                   ░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░          ]],
			[[                                                              ]],
            [[        ▀███▀▀▀██▄███▀▀▀███      ██     ▀███▄   ▀███▀█        ]],
            [[         ██    ██ ██    ▀█     ▄██▄      ███▄    █ ██         ]],
            [[         ██    ██ ██   █      ▄█▀██▄     █ ███   █ ██         ]],
            [[         ██▀▀▀█▄▄ ██████     ▄█  ▀██     █  ▀██▄ █ ██         ]],
            [[         ██    ▀█ ██   █  ▄  ████████    █   ▀██▄█ ▀▀         ]],
            [[         ██    ▄█ ██     ▄█ █▀      ██   █     ███ ▄▄         ]],
            [[        ▄████████▄█████████████▄   ▄████▄███▄    ██ ██        ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button("n", "" .. " New file", "<cmd>ene <BAR> startinsert <CR>"),
			dashboard.button("e", "" .. " File tree", "<cmd>Neotree toggle float<CR>"),
			dashboard.button("f", "" .. " Find file", "<cmd>Telescope find_files <CR>"),
			dashboard.button("l", "" .. " Lazy", "<cmd>Lazy<CR>"),
			dashboard.button("m", "" .. " Mason", "<cmd>Mason<CR>"),
			dashboard.button("q", "" .. " Quit", "<cmd>qa<CR>"),
		}
		local function footer()
			return "MORE BEANZZ ANYONE?!"
		end

		dashboard.section.footer.val = footer()

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true
		alpha.setup(dashboard.opts)

	end
}
