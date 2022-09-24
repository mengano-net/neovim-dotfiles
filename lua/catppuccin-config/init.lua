-- Exit if can't load module(s)
local status_ok, catppuccin = pcall(require, "catppuccin")
if not status_ok then
  print("Couldn't require module 'catppuccin'.")
  return
end


vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha

catppuccin.setup()
