-- Exit if can't load module(s)
local status_ok, tokyonight = pcall(require, "tokyonight")
if not status_ok then
  print("Couldn't require module 'tokyonight'.")
  return
end

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_lualine_bold = 'true'
vim.g.tokyonight_italic_functions = '1'
vim.g.tokyonight_sidebars = { 'terminal' }

tokyonight.setup()
