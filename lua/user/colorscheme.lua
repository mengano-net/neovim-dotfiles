local colorscheme = "darkplus"
-- local colorscheme = "rose-pine"
-- local colorscheme = "tokyonight"
-- local colorscheme = "nord"
-- local colorscheme = "catppuccin"
-- local colorscheme = "cubandusk"

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

if colorscheme == "nord" then
  vim.g.nord_contrast = 'false'
  vim.g.nord_borders = 'true'
  vim.g.nord_disable_background = 'true'
  vim.g.nord_italic = 'false'
end

if colorscheme == "rose-pine" then
  require('rose-pine').setup({
    dark_variant = 'moon',
    border = 'highlight_hi',
    disable_italics = true,
    --[[ highlight_groups = {
      ColorColumn = { bg = 'rose' }
    }, ]]
  })
end

if colorscheme == "catppuccin" then
  vim.cmd "let g:catppuccin_flavour = 'mocha'"
  require("catppuccin").setup({
    styles = {
      comments = {},
      conditionals = {},
    }
  })
end

pcall(vim.cmd, "colorscheme " .. colorscheme)
