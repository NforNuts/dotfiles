return {
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
}
