-- skip if module(s) isn't loaded
local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  return
end

onedark.setup {
  style = 'darker',
  transparent = true, -- Show/hide background
  -- style = 'warmer',
  term_colors = true,
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = false, -- use undercurl instead of underline for diagnostics
    background = false, -- use background color for virtual text
  },
}

-- onedark.load()
