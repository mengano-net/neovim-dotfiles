vim.opt.termguicolors = true
require("bufferline").setup{}
--
-- mappings
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', {silent = true})
