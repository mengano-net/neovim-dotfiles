-- Exit if can't load module(s)
local status_ok, nord = pcall(require, "nord")
if not status_ok then
  print("Couldn't require module 'nord'.")
  return
end

vim.g.nord_contrast = 'false'
vim.g.nord_borders = 'true'
vim.g.nord_disable_background = 'true'
vim.g.nord_italic = 'true'
