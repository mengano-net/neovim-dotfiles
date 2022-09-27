-- local colorscheme = "catppuccin"
-- local colorscheme = "darkplus"
local colorscheme = "tokyonight"

local status_ok, _ = pcall(require, colorscheme)
if not status_ok then
  print("colorscheme not found: " .. colorscheme)
  return
end

if colorscheme == "tokyonight" then
  pcall(vim.cmd, "colorscheme " .. "tokyonight-night")
  return
end

pcall(vim.cmd, "colorscheme " .. colorscheme)
