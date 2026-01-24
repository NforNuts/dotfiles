return {
  {
    "mfussenegger/nvim-dap",

    -- インサートモードで<C-v>を押した後、目的のキーバインドを入力するとNeovimが解釈しているキーコードが表示される
    -- stylua: ignore
    keys = {
      -- { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<F29>", function() require("dap").continue() end, desc = "Run/Continue" }, -- <C-F5>
      -- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      -- { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      -- { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
      { "<F35>", function() require("dap").step_into() end, desc = "Step Into" }, -- <C-F11>
      -- { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      -- { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      -- { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<F23>", function() require("dap").step_out() end, desc = "Step Out" }, -- <S-F11>
      { "<F7>", function() require("dap").step_over() end, desc = "Step Over" },
      -- { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      -- { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      -- { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<F41>", function() require("dap").terminate() end, desc = "Terminate" }, -- <C-S-F5>
      -- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
  },
  {
    "mrcjkb/rustaceanvim",

    version = "^7", -- Recommended
    -- stylua: ignore
    keys = {
      { "<F5>", function() vim.cmd.RustLsp("debuggables") end, desc = "Run Debuggables"},
    },
  },
}
