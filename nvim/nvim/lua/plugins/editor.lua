return {
	--====================
	--   nvim-autopairs
	--====================
	{
		"windwp/nvim-autopairs",

		event = "InsertEnter",

		opts = {
			map_c_h = true,
		},

		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")
			local cond = require("nvim-autopairs.conds")

			local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
			npairs.add_rules({
				-- Rule for a pair with left-side ' ' and right side ' '
				Rule(" ", " ")
					-- Pair will only occur if the conditional function returns true
					:with_pair(function(opts1)
						-- We are checking if we are inserting a space in (), [], or {}
						local pair = opts1.line:sub(opts1.col - 1, opts1.col)
						return vim.tbl_contains({
							brackets[1][1] .. brackets[1][2],
							brackets[2][1] .. brackets[2][2],
							brackets[3][1] .. brackets[3][2],
						}, pair)
					end)
					:with_move(cond.none())
					:with_cr(cond.none())
					-- We only want to delete the pair of spaces when the cursor is as such: ( | )
					:with_del(
						function(opts1)
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local context = opts1.line:sub(col - 1, col + 2)
							return vim.tbl_contains({
								brackets[1][1] .. "  " .. brackets[1][2],
								brackets[2][1] .. "  " .. brackets[2][2],
								brackets[3][1] .. "  " .. brackets[3][2],
							}, context)
						end
					),
			})

			-- For each pair of brackets we will add another rule
			for _, bracket in pairs(brackets) do
				npairs.add_rules({
					-- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
					Rule(bracket[1] .. " ", " " .. bracket[2])
						:with_pair(cond.none())
						:with_move(function(opts1)
							return opts1.char == bracket[2]
						end)
						:with_del(cond.none())
						:use_key(bracket[2])
						-- Removes the trailing whitespace that can occur without this
						:replace_map_cr(function(_)
							return "<C-c>2xi<CR><C-c>O"
						end),
				})
			end
		end,
	},

	--=================
	--   flash.nvim
	--=================
	-- {
	-- 	"folke/flash.nvim",
	--
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	opts = {},
	--
	--    --stylua: ignore
	-- 	keys = {
	-- 		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
	-- 		{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
	-- 		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
	-- 		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
	-- 		{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
	-- 	},
	-- },

	--====================
	--   which-key.nvim
	--====================
	{
		"folke/which-key.nvim",

		dependencies = { "mini.icons" },
		event = "VeryLazy",

		opts = {
			preset = "helix",
		},
	},

	--===============
	--   grug-far
	--===============
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},

	--===================
	--   mini.surround
	--===================
	{
		"nvim-mini/mini.surround",

		event = { "BufReadPre", "BufNewFile", "InsertEnter" },

		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},

	--==============
	--   oil.nvim
	--==============
	{
		"stevearc/oil.nvim",

		dependencies = { "mini.icons", "malewicz1337/oil-git.nvim" },

		opts = {
			keymaps = {
				["q"] = { "actions.close", mode = "n" },
				["<esc>"] = { "actions.close", mode = "n" },
			},
		},

    --stylua: ignore
    keys = {
      { "-", "<cmd>Oil<cr>",                                 desc = "Open Parent Directory in Oil" },
      { "_", function() vim.cmd("Oil " .. vim.uv.cwd()) end, desc = "Open CWD in Oil" },
    },
	},

	--=================
	--   snacks.nvim
	--=================
	{
		"snacks.nvim",

		dependencies = {
			{
				"jedrzejboczar/possession.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				keys = {
					{ "<leader>fs", "", desc = "+Session" },
					{ "<leader>fss", ":PossessionSave<cr>", desc = "Save Session", silent = true },
					{ "<leader>fsr", ":PossessionLoad<cr>", desc = "Restore Session", silent = true },
					{ "<leader>fsl", ":PossessionList<cr>", desc = "List Sessions", silent = true },
				},
				opts = {},
			},
		},

    --stylua: ignore
    keys = {
      { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },

      { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },

      { "<leader>f",       "",                                                                     desc = "+files" },
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
      { "<leader>fm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },

      {
        "<leader>:",
        function()
          Snacks.picker.command_history({
            layout = {
              layout = {
                row = vim.api.nvim_win_get_height(vim.api.nvim_get_current_win()) * 0.3 - 1,
                position = "float",
              },
            },
          })
        end,
        desc = "Command History",
      },
    },

		opts = {
			picker = {
				enabled = true,
				exclude = {
					".git",
					"node_modules",
					"Library",
					"Applications",
				},
				sources = {
					explorer = {
						hidden = true,
						auto_close = true,
						layout = {
							layout = {
								position = "right",
							},
						},
					},
				},
			},
			explorer = { enabled = true },
		},
	},

	--===============
	--   harpoon2
	--===============
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
			settings = {
				save_on_toggle = true,
			},
		},
		keys = function()
			local keys = {
				{
					"<leader>H",
					function()
						require("harpoon"):list():add()
					end,
					desc = "Harpoon File",
				},
				{
					"<leader>h",
					function()
						local harpoon = require("harpoon")
						harpoon.ui:toggle_quick_menu(harpoon:list())
					end,
					desc = "Harpoon Quick Menu",
				},
			}

			for i = 1, 9 do
				table.insert(keys, {
					"<leader>" .. i,
					function()
						require("harpoon"):list():select(i)
					end,
					desc = "Harpoon to File " .. i,
				})
			end
			return keys
		end,
	},

	--==================
	--   quicker.nvim
	--==================
	{
		"stevearc/quicker.nvim",

		ft = "qf",
		opts = {},

		config = function(_, opts)
			local quicker = require("quicker")

			quicker.setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("quicker-augroup", { clear = true }),
				pattern = "qf",
				callback = function(args)
					vim.keymap.set("n", ">", function()
						quicker.expand({ before = 2, after = 2, add_to_existing = true })
					end, { buffer = args.buf })

					vim.keymap.set("n", "<", function()
						quicker.collapse()
					end, { buffer = args.buf })
				end,
			})
		end,
	},
}
