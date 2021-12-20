-- Exit if can't load module
local status_ok, comment = pcall(require, "bufferline")
if not status_ok then
  return
end

vim.opt.termguicolors = true
require("bufferline").setup{}
--
-- mappings
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', {silent = true})
