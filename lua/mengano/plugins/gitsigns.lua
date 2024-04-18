return {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("gitsigns").setup({
            signs = {
                add = {
                    hl = "GitSignsAdd",
                    text = "▎",
                    numhl = "GitSignsAddNr",
                    linehl = "GitSignsAddLn",
                },
                change = {
                    hl = "GitSignsChange",
                    text = "▎",
                    numhl = "GitSignsChangeNr",
                    linehl = "GitSignsChangeLn",
                },
            },
            attach_to_untracked = true,
            --
            ----------------------------------------------------------------------
            --                 keymaps belonging to this plugin                 --
            ----------------------------------------------------------------------

            vim.keymap.set(
                { "n" },
                "<leader>GB",
                "<cmd>lua require('gitsigns').blame_line{full=false}<cr>",
                { desc = "( B )lame" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>GS",
                "<cmd>Gitsigns stage_buffer<cr>",
                { desc = "( S )tage buffer" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>GR",
                "<cmd>Gitsigns reset_buffer<cr>",
                { desc = "( R )eset buffer" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hj",
                "<cmd>Gitsigns next_hunk<cr>",
                { desc = "( j )ext" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hk",
                "<cmd>Gitsigns prev_hunk<cr>",
                { desc = "( k )revious" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hp",
                "<cmd>Gitsigns preview_hunk<cr>",
                { desc = "( p )review" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hr",
                "<cmd>Gitsigns reset_hunk<cr>",
                { desc = "( r )eset" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hs",
                "<cmd>Gitsigns stage_hunk<cr>",
                { desc = "( s )tage" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hu",
                "<cmd>Gitsigns undo_stage_hunk<cr>",
                { desc = "( u )n-Stage" }
            ),
        })
    end,
}
