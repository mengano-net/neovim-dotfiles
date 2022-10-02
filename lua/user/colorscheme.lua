local colorscheme = "darkplus"
-- local colorscheme = "rose-pine"
-- local colorscheme = "tokyonight"
-- local colorscheme = "onenord"

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
end

if colorscheme == "darkplus" then
  vim.cmd "hi TelescopeBorder guifg=#569cd6"
end

if colorscheme == "nord" then
  vim.g.nord_contrast = 'false'
  vim.g.nord_borders = 'true'
  vim.g.nord_disable_background = 'true'
  vim.g.nord_italic = 'false'
end

pcall(vim.cmd, "colorscheme " .. colorscheme)
