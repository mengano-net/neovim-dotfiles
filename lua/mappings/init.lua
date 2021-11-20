local map = vim.api.nvim_set_keymap

map('n', '<Leader>w', ':write<CR>', {noremap = true})
map('i', 'jk', '<Esc>', {noremap = true})
map('n', '<Tab>', ':BufferLineCycleNext<CR>', {silent = true})
map('n', '<Leader>sh', ':split term://zsh<cr>', {noremap = true})
map('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
map('n', 'nh', ':nohl<cr>', {noremap = true})
-- paste yanked, not deleted, not system copied
map('n', '<leader>p', '"0p', {noremap = true})

-- better navigating splits
map('n', '<C-h>', '<C-w><C-h>', {noremap = true})
map('n', '<C-j>', '<C-w><C-j>', {noremap = true})
map('n', '<C-k>', '<C-w><C-k>', {noremap = true})
map('n', '<C-l>', '<C-w><C-l>', {noremap = true})

-- While on visual mode, this allows selections to remain selected for aditional actions without
-- loosing the visual block selection
map('v', '<', '<gv', {noremap = true})
map('v', '>', '>gv', {noremap = true})

-- "Y" will select remainder of the line, start at cursor,
-- similar to "D" and "C" for deleting and replacing respectively
map('n', 'Y', 'y$', {noremap = true})

-- Moving visual blocks up/down
map('v', 'J', ':m \'>+1<cr>gv=gv', {noremap = true})
map('v', 'K', ':m \'<-2<cr>gv=gv', {noremap = true})
-- utils.map('i', '<c-j>', '<esc>:m .+1<cr>')
-- utils.map('i', '<c-k>', '<esc>:m .-2<cr>')

-- Keeping it centered when hitting `n` or `N` after a search
map('n', 'n', 'nzzzv', {noremap = true})
map('n', 'N', 'Nzzzv', {noremap = true})
map('n', 'J', 'mzJ`z', {noremap = true})

-- Undo breakpoints
map('i', ',', ',<c-g>u', {noremap = true})
map('i', '.', '.<c-g>u', {noremap = true})
map('i', '!', '!<c-g>u', {noremap = true})
map('i', '?', '?<c-g>u', {noremap = true})

-- Press * to search word under cursor, then hit map below for search/replace.
map('n', '<leader>r', ':%s///g<left><left>', {noremap = true})
-- same but with confirmation for each change
map('n', '<leader>rc', ':%s///gc<left><left><left>', {noremap = true})

-- Search/replace on a visual block. You can do that by pressing *, then visual select
map('x', '<leader>r', ':%s///g<left><left>', {noremap = true})
-- same but with confirmation for each change
map('x', '<leader>rc', ':%s///gc<left><left><left>', {noremap = true})

-- Telescope maps, see lua/plugins/telescope.lua
-- utils.map('n', '<leader>tf', ':lua require(\'plugins.telescope\').find_files()<cr>')
-- map('n', '<leader>f', ':lua require(\'plugins.telescope\').file_browser()<cr>')
-- map('n', '<leader>gs', ':lua require(\'plugins.telescope\').grep_string()<cr>')
-- map('n', '<leader>jl', ':lua require(\'plugins.telescope\').jumplist()<cr>')
-- map('n', '<leader>lg', ':lua require(\'plugins.telescope\').live_grep()<cr>')
-- map('n', '<leader>nc', ':lua require(\'plugins.telescope\').neovim_config()<cr>')
-- map('n', '<leader>gb', ':lua require(\'plugins.telescope\').git_branches()<cr>')
-- map('n', '<leader>gc', ':lua require(\'plugins.telescope\').git_commits()<cr>')
-- map('n', '<leader>ch', ':lua require(\'plugins.telescope\').command_history()<cr>')
-- map('n', '<leader>cl', ':lua require\'telescope.builtin\'.commands()<cr>')
-- map('n', '<leader>no', ':lua require\'plugins.telescope\'.notes()<cr>')
-- map('n', '<leader>ht', ':lua require\'plugins.telescope\'.help_tags()<cr>')
