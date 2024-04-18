-- DO NOT add keymaps for ANY plugins here, this is ONLY for keymaps relating to
-- functionality that is built into Neovim only.
-- The keymaps, relating to each plugin should be added on said plaugin's
-- configuration lua file, usually found in /lua/mengano/plugins

-- Function wrapper for mapping custom keybindings
local function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

keymap("i", "jk", "<Esc>")

-- When you remove a selection character under cursor with `x`, do not also copy
-- to register
keymap("n", "x", '"_x')

keymap("n", "<Tab>", ":bnext<CR>", { silent = true })
keymap("n", "<S-Tab>", ":bprevious<CR>", { silent = true })

-- paste yanked, not deleted, not system copied
keymap("n",
    "<leader>p",
    '"0p',
    { desc = "( p )aste yanked, not deleted, copied" }
)

-- Replace all instances of highlighted words
keymap("v",
    "<leader>Er",
    '"hy:%s/<C-r>h//g<left><left>',
    { desc = "( r )eplace all instances of selected string" }
)

-- While on visual mode, this allows selections to remain selected for aditional
-- actions without loosing the visual block selection
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Moving visual blocks up/down
keymap("v", "J", ":m '>+1<cr>gv=gv")
keymap("v", "K", ":m '<-2<cr>gv=gv")

-- Splits
keymap("n", "ss", ":new<Return><C-w>j")
keymap("n", "sv", ":vnew<Return><C-w>l")
-- keymap("n", "<C-h>", "<C-w>h")
-- keymap("n", "<C-j>", "<C-w>j")
-- keymap("n", "<C-k>", "<C-w>k")
-- keymap("n", "<C-l>", "<C-w>l")
-- keymap("n", "<C-Up>", ":resize -2<CR>")
-- keymap("n", "<C-Down>", ":resize +2<CR>")

-- Keeping it centered when hitting `n` or `N` after a search
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "J", "mzJ`z")

-- Undo breakpoints
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", "!", "!<c-g>u")
keymap("i", "?", "?<c-g>u")
