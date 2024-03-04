return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set({ "n" }, "<leader>Gc", "<cmd>Git commit -s<cr>", { desc = "Commit" })
        vim.keymap.set({ "n" }, "<leader>Gs", "<cmd>Ge:<cr>", { desc = "Status" })
        vim.keymap.set({ "n" }, "<leader>Gp", "<cmd>Git pull<cr>", { desc = "Pull" })
        vim.keymap.set({ "n" }, "<leader>GP", "<cmd>Git push<cr>", { desc = "Push" })
    end,
}
