-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = "minifiles",
  callback = function(ev)
    vim.keymap.set("n", "q", function()
      require("mini.files").close()
    end, { buffer = ev.buf })
    vim.keymap.set("n", "<cr>", function()
      require("mini.files").go_in({ close_on_file = true })
    end, { buffer = ev.buf })
  end,
})
