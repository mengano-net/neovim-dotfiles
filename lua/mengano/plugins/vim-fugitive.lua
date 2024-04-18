return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set({ "n" },
            "<leader>Gc",
            "<cmd>Git commit -s<cr>",
            { desc = "( c )ommit" }
        )
        vim.keymap.set({ "n" },
            "<leader>Gs",
            "<cmd>Ge:<cr>",
            { desc = "( s )tatus" }
        )
        vim.keymap.set({ "n" },
            "<leader>Gp",
            "<cmd>Git pull<cr>",
            { desc = "( p )ull" }
        )
        vim.keymap.set({ "n" },
            "<leader>GP",
            "<cmd>Git push<cr>",
            { desc = "( P )ush" }
        )
    end,
}
