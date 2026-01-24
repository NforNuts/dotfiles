local function __get_hl_color_for(prop)
	local hl = vim.api.nvim_get_hl(0, { name = prop, link = false })
	return string.format("#%06x", hl["fg"])
end

return {
	--================
	--   noice.nvim
	--================
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},

		event = "VeryLazy",

		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = "30%",
					},
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "mini",
				},
			},
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
			},
		},
	},

	--==================
	--   lualine.nvim
	--==================
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "mini.icons" },
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto",
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = { statusline = { "snacks_dashboard" } },
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch" },
				lualine_c = {
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename", path = 1, file_status = true, symbols = { modified = " ", readonly = " " } },
				},

				lualine_x = {
        -- stylua: ignore start
					{
						function() return require("noice").api.status.command.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
						color = function() return { fg = __get_hl_color_for("Statement") } end,
					},
					{
						function() return require("noice").api.status.mode.get() end,
						cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
						color = function() return { fg = __get_hl_color_for("Constant") } end,
					},
					{
						function() return "  " .. require("dap").status() end,
						cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
						color = function() return { fg = __get_hl_color_for("Debug") } end,
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function() return { fg = __get_hl_color_for("Special") } end,
					},
					-- stylua: ignore end

					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
					},
				},

				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},

				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
		},
	},
}
