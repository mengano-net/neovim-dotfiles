local colorscheme = "darkplus"
-- local colorscheme = "rose-pine"
-- local colorscheme = "tokyonight"
-- local colorscheme = "nord"
-- local colorscheme = "everblush"

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

if colorscheme == "nord" then
  vim.g.nord_contrast = 'false'
  vim.g.nord_borders = 'true'
  vim.g.nord_disable_background = 'true'
  vim.g.nord_italic = 'false'
end

if colorscheme == "everblush" then
  local colors = require('everblush.core').get_colors()
  require('everblush').setup({
    nvim_tree = { contrast = true },
    override = {
      ColorColumn = { fg = colors.Comment },
    }
  })
end

----------------------------------------------------------------------
--                 Finally, setting the colorscheme                 --
----------------------------------------------------------------------
pcall(vim.cmd, "colorscheme " .. colorscheme)
