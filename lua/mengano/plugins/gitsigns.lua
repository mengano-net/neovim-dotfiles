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
                { desc = "Blame" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>GS",
                "<cmd>Gitsigns stage_buffer<cr>",
                { desc = "Stage buffer" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>GR",
                "<cmd>Gitsigns reset_buffer<cr>",
                { desc = "Reset buffer" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hb",
                "<cmd>lua require'gitsigns'.blame_line{full=false}<cr>",
                { desc = "Blame line - short" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hB",
                "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>",
                { desc = "Blame line - long" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hj",
                "<cmd>Gitsigns next_hunk<cr>",
                { desc = "Next hunk" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hk",
                "<cmd>Gitsigns prev_hunk<cr>",
                { desc = "Previous hunk" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hp",
                "<cmd>Gitsigns preview_hunk<cr>",
                { desc = "Preview hunk" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hr",
                "<cmd>Gitsigns reset_hunk<cr>",
                { desc = "Reset hunk" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hs",
                "<cmd>Gitsigns stage_hunk<cr>",
                { desc = "Stage hunk" }
            ),
            vim.keymap.set(
                { "n" },
                "<leader>hu",
                "<cmd>Gitsigns undo_stage_hunk<cr>",
                { desc = "Un-Stage hunk" }
            ),
        })
    end,
}
