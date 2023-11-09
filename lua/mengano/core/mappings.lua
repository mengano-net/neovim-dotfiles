local keymap = vim.keymap.set
local opts = { silent = true }

keymap("i", "jk", "<Esc>", opts)

-- When you remove a selection character under cursor with `x`, do not also copy to register
keymap("n", "x", '"_x')

keymap("n", "<Tab>", ":bnext<CR>", { silent = true })
keymap("n", "<S-Tab>", ":bprevious<CR>", { silent = true })

keymap("n", "<leader>p", '"0p', opts) -- paste yanked, not deleted, not system copied

-- While on visual mode, this allows selections to remain selected for aditional actions without
-- loosing the visual block selection
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Moving visual blocks up/down
keymap("v", "J", ":m '>+1<cr>gv=gv", opts)
keymap("v", "K", ":m '<-2<cr>gv=gv", opts)

-- Splits
keymap("n", "ss", ":new<Return><C-w>j", opts)
keymap("n", "sv", ":vnew<Return><C-w>l", opts)
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)

-- Keeping it centered when hitting `n` or `N` after a search
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "J", "mzJ`z", opts)

-- Undo breakpoints
keymap("i", ",", ",<c-g>u", opts)
keymap("i", ".", ".<c-g>u", opts)
keymap("i", "!", "!<c-g>u", opts)
keymap("i", "?", "?<c-g>u", opts)
