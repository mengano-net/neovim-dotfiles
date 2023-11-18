return {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    opts = {
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
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- config = function()
    --     require('gitsigns').setup(opts)
    -- end,
}
