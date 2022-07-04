-- skip if module(s) isn't loaded
local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  return
end

-- vim.g.onedark_style = 'darker'
-- vim.g.onedark_style = 'warm'
-- vim.g.onedark_style = 'deep'

onedark.setup {
  -- style = 'deep'
  style = 'warmer',
  term_colors = true,
  diagnostics = {
    darker = true, -- darker colors for diagnostic
    undercurl = false, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}
-- vim.sdfasdf

onedark.load()
