return {
	"luukvbaal/statuscol.nvim",
	event = 'BufRead',
	opts = function()
		local builtin = require("statuscol.builtin")
		local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

		for type, icon in pairs(signs) do
			local hl = 'DiagnosticSign' .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
		end

		return {
			-- configuration goes here, for example:
			-- relculright = true,
			segments = {
				-- { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { "%s" } },
				{
					sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
					click = "v:lua.ScSa"
				},
				-- {
				-- 	sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
				-- 	click = "v:lua.ScSa"
				-- },
				-- { text = { " " } },
				{
					text = { function(args)
						if args.relnum == 0 then
							return args.lnum
						else
							return args.relnum
						end
					end },
					click = "v:lua.ScLa",
				},
				{ text = { " " } },
			}

		}
	end,
	-- config = true,
	-- config = function()
	-- 	local status, statuscol = pcall(require, "statuscol")
	-- 	if (not status) then return end
	--
	-- 	statuscol.setup()
	--
	-- 	if _G.StatusColumn then
	-- 		return
	-- 	end
	--
	-- 	_G.StatusColumn = {
	-- 		handler = {
	-- 			fold = function()
	-- 				local lnum = vim.fn.getmousepos().line
	--
	-- 				-- Only lines with a mark should be clickable
	-- 				if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
	-- 					return
	-- 				end
	--
	-- 				local state
	-- 				if vim.fn.foldclosed(lnum) == -1 then
	-- 					state = "close"
	-- 				else
	-- 					state = "open"
	-- 				end
	--
	-- 				vim.cmd.execute("'" .. lnum .. "fold" .. state .. "'")
	-- 			end
	-- 		},
	-- 		display = {
	-- 			fold = function()
	-- 				if vim.v.wrap then
	-- 					return ""
	-- 				end
	--
	-- 				local lnum = vim.v.lnum
	-- 				local icon = "  "
	--
	-- 				-- Line isn't in folding range
	-- 				if vim.fn.foldlevel(lnum) <= 0 then
	-- 					return icon
	-- 				end
	--
	-- 				-- Not the first line of folding range
	-- 				if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
	-- 					return icon
	-- 				end
	--
	-- 				if vim.fn.foldclosed(lnum) == -1 then
	-- 					icon = ""
	-- 				else
	-- 					icon = ""
	-- 				end
	--
	-- 				return icon
	-- 			end
	-- 		},
	-- 		sections = {
	-- 			sign_column = {
	-- 				[[%s]]
	-- 			},
	-- 			line_number = {
	-- 				[[%{v:relnum?v:relnum:v:lnum}]]
	-- 			},
	-- 			spacing     = {
	-- 				[[ ]]
	-- 			},
	-- 			folds       = {
	-- 				[[%#FoldColumn#]], -- HL
	-- 				[[%@v:lua.StatusColumn.handler.fold@]],
	-- 				[[%{v:lua.StatusColumn.display.fold()}]]
	-- 			},
	-- 			border      = {
	-- 				[[%#StatusColumnBorder#]], -- HL
	-- 				[[▐]],
	-- 			},
	-- 			padding     = {
	-- 				[[%#StatusColumnBuffer#]], -- HL
	-- 				[[ ]],
	-- 			},
	-- 		},
	-- 		build = function(tbl)
	-- 			local statuscolumn = {}
	--
	-- 			for _, value in ipairs(tbl) do
	-- 				if type(value) == "string" then
	-- 					table.insert(statuscolumn, value)
	-- 				elseif type(value) == "table" then
	-- 					table.insert(statuscolumn, StatusColumn.build(value))
	-- 				end
	-- 			end
	--
	-- 			return table.concat(statuscolumn)
	-- 		end,
	-- 		set_window = function(value)
	-- 			vim.defer_fn(function()
	-- 				vim.api.nvim_win_set_option(vim.api.nvim_get_current_win(), "statuscolumn", value)
	-- 			end, 1)
	-- 		end
	-- 	}
	--
	-- 	vim.opt.statuscolumn = StatusColumn.build({
	-- 		StatusColumn.sections.padding,
	-- 		StatusColumn.sections.sign_column,
	-- 		StatusColumn.sections.line_number,
	-- 		StatusColumn.sections.spacing,
	-- 		StatusColumn.sections.folds,
	-- 		-- StatusColumn.sections.border,
	-- 		StatusColumn.sections.padding
	-- 	})
	--
	-- 	local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
	--
	-- 	for type, icon in pairs(signs) do
	-- 		local hl = 'DiagnosticSign' .. type
	-- 		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
	-- 	end
	-- end
}
