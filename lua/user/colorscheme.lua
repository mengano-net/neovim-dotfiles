-- local colorscheme = "darkplus"
local colorscheme = "catppuccin"
-- local colorscheme = "tokyonight"

local status_ok, _ = pcall(require, colorscheme)
if not status_ok then
  print("colorscheme not found: " .. colorscheme)
  return
end

if colorscheme == "tokyonight" then
  require("tokyonight").setup({
    style = "night",
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
      sidebars = { "terminal" },
      lualine_bold = false,
    },
  })
  pcall(vim.cmd, "colorscheme " .. "tokyonight-night")
  return
end

if colorscheme == "darkplus" then
  vim.cmd "hi TelescopeBorder guifg=#569cd6"
end

pcall(vim.cmd, "colorscheme " .. colorscheme)
