local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

return {
	--==================
	--   plenary.nvim
	--==================
	{ "nvim-lua/plenary.nvim", lazy = true },

	--=================
	--   mini.icons
	--=================
	{
		"nvim-mini/mini.icons",
		version = false,
		lazy = true,
		opts = {},
		config = function(_, opts)
			local micons = require("mini.icons")
			micons.setup(opts)
			micons.mock_nvim_web_devicons()
		end,
	},

	--=================
	--   snacks.nvim
	--=================
	{
		"folke/snacks.nvim",

		priority = 1000,
		lazy = false,

		opts = {
			bigfile = { enabled = true },
			input = { enabled = true },
			bufdelete = { enabled = true },
			rename = { enabled = true },
			scratch = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			statuscolumn = { enabled = true },
			notifier = { enabled = true },

			dashboard = {
				enabled = true,

				preset = {
					header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 2 },
					{ section = "startup" },
				},
			},

			terminal = {
				win = {
					keys = {
						-- nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
						nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
						nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
						-- nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
					},
				},
			},
		},

    -- stylua: ignore
		keys = {
      { "<leader>b", "", desc = "+buffers" },
			{ "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer", },
			{ "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffer", },

			{ "<c-/>", function() Snacks.terminal() end, desc = "Open Terminal", },
			{ "<c-_>", function() Snacks.terminal() end, desc = "Open Terminal", },
			{ "<c-/>", "<cmd>close<cr>", mode = "t", desc = "Close Terminal" },
			{ "<c-_>", "<cmd>close<cr>", mode = "t", desc = "Close Terminal" },

			{ "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer", },
			{ "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer", },
		},

		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "OilActionsPost",
				callback = function(event)
					if event.data.actions.type == "move" then
						Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
					end
				end,
			})
		end,
	},
}
