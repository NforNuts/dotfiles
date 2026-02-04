return {
	--===============
	--   blink.cmp
	--===============
	{
		"saghen/blink.cmp",

		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		build = "cargo build --release",

		opts = {
			signature = { enabled = true },

			keymap = { preset = "default" },

			cmdline = {
				enabled = true,

				keymap = {
					["<Tab>"] = { "show", "accept" },
					["<CR>"] = { "accept_and_enter", "fallback" },
				},

				completion = {
					menu = {
						auto_show = function(_)
							return vim.fn.getcmdtype() == ":" or vim.fn.getcmdtype() == "@"
						end,
					},
				},
			},

			appearance = {
				kind_icons = {
					Class = " ",
					Color = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Folder = " ",
					Function = "󰊕 ",
					Interface = " ",
					Keyword = " ",
					Method = "󰡱 ",
					Module = " ",
					Operator = " ",
					Property = " ",
					Reference = " ",
					Snippet = "󱄽 ",
					Struct = "󰆼 ",
					Text = " ",
					TypeParameter = " ",
					Unit = " ",
					Value = " ",
					Variable = "󰀫 ",
				},
			},

			completion = {
				ghost_text = { enabled = true },
				documentation = { auto_show = true, auto_show_delay_ms = 500 },
				accept = { auto_brackets = { enabled = true } },
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					cmdline = {
						min_keyword_length = function(ctx)
							-- when typing a command, only show when the keyword is 3 characters or longer
							if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
								return 3
							end
							return 0
						end,
					},
				},
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	--======================
	--   ts-comments.nvim
	--======================
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = { "BufReadPost", "BufNewFile" },
	},

	--=================
	--   snacks.nvim
	--=================
	{
		"snacks.nvim",

		opts = {
			indent = {
				enabled = true,

				animate = {
					enabled = false,
				},

				chunk = {
					enabled = true,
				},
			},
		},
	},

	--========================
	--   todo-comments.nvim
	--========================
	{
		"folke/todo-comments.nvim",

		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		dependencies = { "plenary.nvim" },

    -- stylua: ignore
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end,              desc = "Next Todo Comment" },
      { "[t",         function() require("todo-comments").jump_prev() end,              desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                   desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },

		opts = {},
	},

	--==================
	--   outline.nvim
	--==================
	-- {
	-- 	"hedyhli/outline.nvim",
	-- 	keys = { { "<leader>co", "<cmd>Outline<cr>", desc = "Toggle Outline" } },
	-- 	cmd = "Outline",
	-- 	opts = {},
	-- },

	--==================
	--   trouble.nvim
	--==================
	{
		"folke/trouble.nvim",

		dependencies = { "mini.icons" },
		cmd = { "Trouble" },

		opts = {},

    -- stylua: ignore
    keys = {
      { "<leader>x",  "",                                                           desc = "+quickfix/diagnostics" },
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    },
	},

	--=============
	--   neotest
	--=============
	{
		"nvim-neotest/neotest",

		dependencies = {
			"plenary.nvim",
			"nvim-treesitter",
			"nvim-neotest/nvim-nio",
			"antoinemadec/FixCursorHold.nvim",

			"nvim-neotest/neotest-python",
			{ "fredrikaverpil/neotest-golang", version = "*" },
		},

    -- stylua: ignore
    keys = {
      { "<leader>t",  "",                                                                                 desc = "+test" },
      { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Run File (Neotest)" },
      { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Run All Test Files (Neotest)" },
      { "<leader>tr", function() require("neotest").run.run() end,                                        desc = "Run Nearest (Neotest)" },
      { "<leader>tl", function() require("neotest").run.run_last() end,                                   desc = "Run Last (Neotest)" },
      { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "Toggle Summary (Neotest)" },
      { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "Toggle Output Panel (Neotest)" },
      { "<leader>tS", function() require("neotest").run.stop() end,                                       desc = "Stop (Neotest)" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                 desc = "Toggle Watch (Neotest)" },
    },

		opts = function()
			return {
				adapters = {
					require("neotest-python"),
					require("neotest-golang"),
					require("rustaceanvim.neotest"),
				},
			}
		end,
	},

	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{
		"stevearc/overseer.nvim",

		cmd = {
			"OverseerOpen",
			"OverseerClose",
			"OverseerToggle",
			"OverseerSaveBundle",
			"OverseerLoadBundle",
			"OverseerDeleteBundle",
			"OverseerRunCmd",
			"OverseerRun",
			"OverseerInfo",
			"OverseerBuild",
			"OverseerQuickAction",
			"OverseerTaskAction",
			"OverseerClearCache",
		},

    -- stylua: ignore
    keys = {
      { "<leader>o",  "",                             desc = "+overseer" },
      { "<leader>ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
      { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
      { "<leader>ol", "<cmd>OverseerRestartLast<cr>", desc = "Restart Last Task" },
    },

		opts = {
			-- templates = { "builtin", "user" },
			task_list = {
				min_height = { 24, 0.25 },
				bindings = {
					["<C-h>"] = false,
					["<C-j>"] = false,
					["<C-k>"] = false,
					["<C-l>"] = false,
				},
			},
			form = {
				win_opts = {
					winblend = 0,
				},
			},
			confirm = {
				win_opts = {
					winblend = 0,
				},
			},
			task_win = {
				win_opts = {
					winblend = 0,
				},
			},
		},

		config = function(_, opts)
			require("overseer").setup(opts)

			vim.api.nvim_create_user_command("OverseerRestartLast", function()
				local overseer = require("overseer")
				local tasks = overseer.list_tasks({ recent_first = true })
				if vim.tbl_isempty(tasks) then
					vim.notify("No tasks found", vim.log.levels.WARN)
				else
					overseer.run_action(tasks[1], "restart")
				end
			end, {})
		end,
	},

	--************************
	--          Rust
	--************************
	--==================
	--   rustaceanvim
	--==================
	{
		"mrcjkb/rustaceanvim",
		version = "^7",
		ft = "rust",

		init = function()
			local dap = require("dap")

			vim.g.rustaceanvim = {
				-- tools = {},
				-- -- Plugin configuration
				-- -- LSP configuration
				server = {
					on_attach = function(client, bufnr)
						vim.keymap.set("n", "<leader>ca", function()
							vim.cmd.RustLsp("codeAction")
						end, { buffer = bufnr, desc = "Code Actions" })
						vim.keymap.set("n", "K", function()
							vim.cmd.RustLsp({ "hover", "actions" })
						end, { buffer = bufnr, desc = "Hover" })
					end,
					-- default_settings = {
					-- 	-- rust-analyzer language server configuration
					-- 	["rust-analyzer"] = {},
				},
				-- },
				-- DAP configuration
				dap = {
					configuration = {
						name = "basic configuration",
						type = "codelldb",
						request = "launch",
					},
				},
			}
		end,
	},

	{
		"alexpasmantier/krust.nvim",
		ft = "rust",
		opts = {},
	},

	--=================
	--   crates.nvim
	--=================
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},

	-- {
	-- 	"p00f/clangd_extensions.nvim",
	-- 	lazy = true,
	-- 	ft = { "c", "cpp" },
	-- 	keys = {
	-- 		{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
	-- 	},
	--
	-- 	opts = {
	-- 		inlay_hints = {
	-- 			inline = false,
	-- 		},
	-- 	},
	-- },

	--***********************
	--         Lua
	--***********************
	--==================
	--   lazydev.nvim
	--==================
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim/lua/snacks" },
			},
		},
	},
	{
		"blink.cmp",
		opts = {
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
}
