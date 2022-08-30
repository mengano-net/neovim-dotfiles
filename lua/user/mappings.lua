local keymap = vim.api.nvim_set_keymap

keymap("i", "jk", "<Esc>", { noremap = true }) -- exit insert mode with 'jk'

-- NvimTreeToggle
-- moved to whichkey
--[[ local status_ok, nvimtree = pcall(require, "nvim-tree")
if status_ok then
  keymap('n', '<leader>t', ':NvimTreeToggle<CR>', {silent = true})
end ]]

-- deprecated since I'm using toggeterm pluging
-- keymap('n', '<Leader>sh', ':split term://zsh<cr>', {noremap = true})
keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

keymap("n", "<leader>p", '"0p', { noremap = true }) -- paste yanked, not deleted, not system copied

-- While on visual mode, this allows selections to remain selected for aditional actions without
-- loosing the visual block selection
keymap("v", "<", "<gv", { noremap = true })
keymap("v", ">", ">gv", { noremap = true })

-- Moving visual blocks up/down
keymap("v", "J", ":m '>+1<cr>gv=gv", { noremap = true })
keymap("v", "K", ":m '<-2<cr>gv=gv", { noremap = true })

-- Split
keymap("n", "ss", ":new<Return><C-w>j", { silent = true })
keymap("n", "sv", ":vnew<Return><C-w>l", { silent = true })

-- Keeping it centered when hitting `n` or `N` after a search
keymap("n", "n", "nzzzv", { noremap = true })
keymap("n", "N", "Nzzzv", { noremap = true })
keymap("n", "J", "mzJ`z", { noremap = true })

-- Undo breakpoints
keymap("i", ",", ",<c-g>u", { noremap = true })
keymap("i", ".", ".<c-g>u", { noremap = true })
keymap("i", "!", "!<c-g>u", { noremap = true })
keymap("i", "?", "?<c-g>u", { noremap = true })

-- -- Press * to search word under cursor, then hit map below for search/replace.
-- keymap('n', '<leader>r', ':%s///g<left><left>', {noremap = true}) -- moved these to whichkey
-- -- same but with confirmation for each change
-- keymap('n', '<leader>rc', ':%s///gc<left><left><left>', {noremap = true}) -- moved these to whichkey
