local colorscheme = "darkplus"

local status_ok, _ = pcall(require, "darkplus")
if not status_ok then
  print("colorscheme not found: " .. colorscheme)
  return
end

-- vim.cmd("colorscheme darkplus")
pcall(vim.cmd, "colorscheme " .. colorscheme)
