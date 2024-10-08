return {
  {
    "nvim-telescope/telescope.nvim",

    opts = {
      defaults = {
        layout_config = {
          height = 0.6,
          prompt_position = "top",
        },
        sorting_strategy = "ascending",

        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<C-h>"] = false,
          },
        },
      },
    },
  },

  {
    "echasnovski/mini.files",

    keys = {
      {
        "_",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "-",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
    opts = {
      mappings = {
        close = "<esc>",
      },
    },
  },

  {
    "folke/flash.nvim",
    enabled = false,
  },
}
