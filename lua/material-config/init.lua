-- Exit if can't load module(s)
local status_ok, material = pcall(require, "material")
if not status_ok then
  print("Couldn't require module 'material'.")
  return
end

vim.g.material_style = 'darker'

material.setup()
