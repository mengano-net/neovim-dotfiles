-- Exit if can't load module
local status_ok, comment = pcall(require, "colorizer")
if not status_ok then
  return
end

require'colorizer'.setup()
