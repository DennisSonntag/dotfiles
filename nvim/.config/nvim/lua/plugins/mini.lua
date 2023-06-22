return {
	{ "echasnovski/mini.cursorword", event = "BufRead", opts = { delay = 10, } },
	{ "echasnovski/mini.move",       event = "BufRead", config = true },
	{ "echasnovski/mini.pairs",      event = "BufRead", config = true },
	{
		"echasnovski/mini.hipatterns",
		event = "BufRead",
		opts = function()
			local hipatterns = require("mini.hipatterns")

			local words = { red = "#ff0000", green = "#00ff00", blue = "#0000ff", purple = "#ff00ff", black = "#000000" }
			local keys = {}
			for key, _ in pairs(words) do
				table.insert(keys, key)
			end

			local word_color_group = function(_, match)
				match = string.lower(match)
				local hex = words[match]
				if hex == nil then return nil end
				return hipatterns.compute_hex_color_group(hex, "bg")
			end

			local function rgbToHex(rgb)
				local hexadecimal = ""

				for _, value in pairs(rgb) do
					local hex = ""

					while (value > 0) do
						local index = math.fmod(value, 16) + 1
						value = math.floor(value / 16)
						hex = string.sub("0123456789ABCDEF", index, index) .. hex
					end

					if (string.len(hex) == 0) then
						hex = "00"
					elseif (string.len(hex) == 1) then
						hex = "0" .. hex
					end

					hexadecimal = hexadecimal .. hex
				end

				return hexadecimal
			end

			local rgb_u8_group = function(_, match)
				local r, g, b = match:match("%((%d+),%s*(%d+),%s*(%d+)%)")
				r = tonumber(r)
				g = tonumber(g)
				b = tonumber(b)
				local hex = "#" .. rgbToHex({ r, g, b })
				if hex == nil then return nil end
				return hipatterns.compute_hex_color_group(hex, "bg")
			end
			local rgb_float_group = function(_, match)
				local r, g, b = match:match("rgb%s*%((%s*%d*%.?%d+%s*),(%s*%d*%.?%d+%s*),(%s*%d*%.?%d+%s*)%)")
				r = tonumber(r)
				g = tonumber(g)
				b = tonumber(b)
				local hex = nil
				if r <= 1 and g <= 1 and b <= 1 then
					r = math.floor(r * 255)
					g = math.floor(g * 255)
					b = math.floor(b * 255)

					hex = "#" .. rgbToHex({ r, g, b })
				end

				if hex == nil then return nil end
				return hipatterns.compute_hex_color_group(hex, "bg")
			end

			return {
				highlighters = {
					-- Highlight standalone "FIXME", "HACK", "TODO", "NOTE"
					fixme          = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack           = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo           = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note           = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					-- word_color     = { pattern = "%S+", group = word_color_group },
					word_color     = { pattern = "(.*)(" .. table.concat(keys, "|") .. ")(.*)", group = word_color_group },
					bevy_rgb_u8    = { pattern = "rgb_u8%b()", group = rgb_u8_group },
					bevy_rgb_float = { pattern = "rgb%b()", group = rgb_float_group },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color      = hipatterns.gen_highlighter.hex_color(),
				},
			}
		end

	},
	{
		"echasnovski/mini.comment",
		event = "BufRead",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo
						.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.ai",
		event = "BufRead",
		opts = {
			custom_textobjects = {
				--Camel case
				s = {
					{
						"%u[%l%d]+%f[^%l%d]",
						"%f[%S][%l%d]+%f[^%l%d]",
						"%f[%P][%l%d]+%f[^%l%d]",
						"^[%l%d]+%f[^%l%d]",
					},
					"^().*()$"
				}
			}

		}
	},
	{
		"echasnovski/mini.surround",
		event = "BufRead",
		opts = {
			mappings = {
				add = "msa", -- Add surrounding in Normal and Visual modes
				delete = "msd", -- Delete surrounding
				find = "msf", -- Find surrounding (to the right)
				find_left = "msF", -- Find surrounding (to the left)
				highlight = "msh", -- Highlight surrounding
				replace = "msr", -- Replace surrounding
				update_n_lines = "msn", -- Update `n_lines`
			},
		}
	},
}
