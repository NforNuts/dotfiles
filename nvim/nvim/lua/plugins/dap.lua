local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
	local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
		if config.type and config.type == "java" then
			---@diagnostic disable-next-line: return-type-mismatch
			return new_args
		end
		return require("dap.utils").splitstr(new_args)
	end
	return config
end

return {
	{
		"mfussenegger/nvim-dap",

		dependencies = {
			"nvim-dap-ui",
			"nvim-dap-python",
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		},

    -- stylua: ignore
    keys = {
      { "<leader>d",   "",                                                                                   desc = "+debug" },
      { "<leader>dB",  function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<F9>",        function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<f29>",       function() require("dap").continue() end,                                             desc = "<C-F5> Run/Continue" },             -- <C-F5>
      { "<leader>da",  function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
      { "<leader>dC",  function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>dg",  function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
      { "<F35>",       function() require("dap").step_into() end,                                            desc = "Step Into" },
      { "<leader>dj",  function() require("dap").down() end,                                                 desc = "<C-F11> Down" },                    -- <C-F11>
      { "<leader>dk",  function() require("dap").up() end,                                                   desc = "Up" },
      { "<leader>dl",  function() require("dap").run_last() end,                                             desc = "Run Last" },
      { "<F23>",       function() require("dap").step_out() end,                                             desc = "<S-F11> Step Out" },                -- <S-F11>
      { "<F7>",        function() require("dap").step_over() end,                                            desc = "Step Over" },                       -- <F7>
      { "<leader>dP",  function() require("dap").pause() end,                                                desc = "Pause" },
      { "<leader>dr",  function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>ds",  function() require("dap").session() end,                                              desc = "Session" },
      { "<F41>",       function() require("dap").terminate() end,                                            desc = "<C-S-F5> Terminate" },              -- <C-S-F5>
      { "<leader>dw",  function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },

      { "<leader>dPt", function() require('dap-python').test_method() end,                                   desc = "Debug Method",           ft = "python" },
      { "<leader>dPc", function() require('dap-python').test_class() end,                                    desc = "Debug Class",            ft = "python" },
    },

		config = function(_, opts)
			vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      --stylua: ignore start
      vim.fn.sign_define("DapStopped",
        { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" })
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "", linehl = "DiagnosticInfo", numhl = "" })
			-- stylua: ignore end

			local vscode = require("dap.ext.vscode")
			local json = require("plenary.json")
			vscode.json_decode = function(str)
				return vim.json.decode(json.json_strip_comments(str))
			end

			require("dap-python").setup("uv")

			local dap = require("dap")
			-- if not dap.adapters["codelldb"] then
			-- 	require("dap").adapters["codelldb"] = {
			-- 		type = "server",
			-- 		-- host = "localhost",
			-- 		port = "${port}",
			-- 		executable = {
			-- 			command = "codelldb",
			-- 			args = {
			-- 				"--port",
			-- 				"${port}",
			-- 			},
			-- 		},
			-- 	}
			-- end
      -- stylua: ignore
			for _, lang in ipairs({ "c", "cpp"--[[, "rust"]] }) do
				dap.configurations[lang] = {
					{
						type = "codelldb",
						request = "launch",
						name = "Launch file",
						program = function()
							if lang == "rust" then
                -- stylua: ignore
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug" .. "/" .. vim.fs.basename(vim.fn.getcwd()), "file")
							else
								return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
							end
						end,
						cwd = "${workspaceFolder}",
					},
					{
						type = "codelldb",
						request = "attach",
						name = "Attach to process",
						pid = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
    },
		opts = {},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		lazy = true,
	},
}
