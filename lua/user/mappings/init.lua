local map = vim.api.nvim_set_keymap

map("i", "jk", "<Esc>", { noremap = true }) -- exit insert mode with 'jk'

-- NvimTreeToggle
-- moved to whichkey
--[[ local status_ok, nvimtree = pcall(require, "nvim-tree")
if status_ok then
  map('n', '<leader>t', ':NvimTreeToggle<CR>', {silent = true})
end ]]

-- deprecated since I'm using toggeterm pluging
-- map('n', '<Leader>sh', ':split term://zsh<cr>', {noremap = true})
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

map("n", "<leader>p", '"0p', { noremap = true }) -- paste yanked, not deleted, not system copied

-- While on visual mode, this allows selections to remain selected for aditional actions without
-- loosing the visual block selection
map("v", "<", "<gv", { noremap = true })
map("v", ">", ">gv", { noremap = true })

-- Moving visual blocks up/down
map("v", "J", ":m '>+1<cr>gv=gv", { noremap = true })
map("v", "K", ":m '<-2<cr>gv=gv", { noremap = true })

-- Split
map("n", "ss", ":new<Return><C-w>j", { silent = true })
map("n", "sv", ":vnew<Return><C-w>l", { silent = true })

-- Keeping it centered when hitting `n` or `N` after a search
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })
map("n", "J", "mzJ`z", { noremap = true })

-- Undo breakpoints
map("i", ",", ",<c-g>u", { noremap = true })
map("i", ".", ".<c-g>u", { noremap = true })
map("i", "!", "!<c-g>u", { noremap = true })
map("i", "?", "?<c-g>u", { noremap = true })

-- -- Press * to search word under cursor, then hit map below for search/replace.
-- map('n', '<leader>r', ':%s///g<left><left>', {noremap = true}) -- moved these to whichkey
-- -- same but with confirmation for each change
-- map('n', '<leader>rc', ':%s///gc<left><left><left>', {noremap = true}) -- moved these to whichkey
