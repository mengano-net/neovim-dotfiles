-- skip if module(s) isn't loaded
local status_ok, comment = pcall(require, "onedark")
if not status_ok then
  return
end

-- vim.g.onedark_style = 'darker'
-- vim.g.onedark_style = 'warm'
vim.g.onedark_style = 'deep'
