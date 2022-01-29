local map = vim.api.nvim_set_keymap

-- moved to whichkey
-- map('n', '<Leader>w', ':write<cr>', {noremap = true})
map("i", "jk", "<Esc>", { noremap = true })
-- skip if module(s) isn't loaded
local status_ok, bufferline = pcall(require, "bufferline")
if status_ok then
	map("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
end

-- NvimTreeToggle
-- moved to whichkey
--[[ local status_ok, nvimtree = pcall(require, "nvim-tree")
if status_ok then
  map('n', '<leader>t', ':NvimTreeToggle<CR>', {silent = true})
end ]]

-- deprecated since I'm using toggeterm pluging
-- map('n', '<Leader>sh', ':split term://zsh<cr>', {noremap = true})
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- moved to whichkey
-- map('n', '<leader>x', ':bd!<cr>', {noremap = true})
-- map('n', 'nh', ':nohl<cr>', {noremap = true})
map("n", "<leader>p", '"0p', { noremap = true }) -- paste yanked, not deleted, not system copied

-- better navigating splits
map("n", "<C-h>", "<C-w><C-h>", { noremap = true })
map("n", "<C-j>", "<C-w><C-j>", { noremap = true })
map("n", "<C-k>", "<C-w><C-k>", { noremap = true })
map("n", "<C-l>", "<C-w><C-l>", { noremap = true })

-- While on visual mode, this allows selections to remain selected for aditional actions without
-- loosing the visual block selection
map("v", "<", "<gv", { noremap = true })
map("v", ">", ">gv", { noremap = true })

-- "Y" will select remainder of the line, start at cursor,
-- similar to "D" and "C" for deleting and replacing respectively
-- map('n', 'Y', 'y$', {noremap = true}) -- moved to whichkey

-- Moving visual blocks up/down
map("v", "J", ":m '>+1<cr>gv=gv", { noremap = true })
map("v", "K", ":m '<-2<cr>gv=gv", { noremap = true })
-- utils.map('i', '<c-j>', '<esc>:m .+1<cr>')
-- utils.map('i', '<c-k>', '<esc>:m .-2<cr>')

-- Keeping it centered when hitting `n` or `N` after a search
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })
map("n", "J", "mzJ`z", { noremap = true })

-- Undo breakpoints
map("i", ",", ",<c-g>u", { noremap = true })
map("i", ".", ".<c-g>u", { noremap = true })
map("i", "!", "!<c-g>u", { noremap = true })
map("i", "?", "?<c-g>u", { noremap = true })

-- moved these to whichkey
-- -- Press * to search word under cursor, then hit map below for search/replace.
-- map('n', '<leader>r', ':%s///g<left><left>', {noremap = true})
-- -- same but with confirmation for each change
-- map('n', '<leader>rc', ':%s///gc<left><left><left>', {noremap = true})

-- Search/replace on a visual block. You can do that by pressing *, then visual select
map("x", "<leader>r", ":%s///g<left><left>", { noremap = true })
-- same but with confirmation for each change
map("x", "<leader>rc", ":%s///gc<left><left><left>", { noremap = true })
