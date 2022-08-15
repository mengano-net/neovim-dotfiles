-- Exit if can't load module(s)
local status_ok, material = pcall(require, "material")
if not status_ok then
  return
end

material.setup({
  -- Enable borders between verticaly split windows
  borders = true,
  -- Popup menu style ( can be: 'dark', 'light', 'colorful' or 'stealth' )
  popup_menu = "colorful",
  text_contrast = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = true -- Enable higher contrast text for darker style
	},
  -- custom_highlights = {
  --   CursorLine = '#0000FF',
  --   LineNr = '#FF0000'
  -- }
})
