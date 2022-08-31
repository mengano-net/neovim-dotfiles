local colorscheme = "darkplus"
-- local colorscheme = "neobones"

local status_ok, _ = pcall(require, colorscheme)
if not status_ok then
  print("colorscheme not found: " .. colorscheme)
  return
end

pcall(vim.cmd, "colorscheme " .. colorscheme)
