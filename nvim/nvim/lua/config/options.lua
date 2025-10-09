-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false

vim.g.lazyvim_blink_main = true
vim.g.lazyvim_prettier_needs_config = true

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_scroll_animation_length = 0
  vim.g.neovide_position_animatino_length = 0

  vim.g.neovide_opacity = 0.85
  vim.g.neovide_window_blurred = true
end
