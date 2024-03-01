return {
    "s1n7ax/nvim-comment-frame",
    dependencies = { "nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        {
            "<leader>ec",
            "<cmd>lua require('nvim-comment-frame').add_comment()<cr>",
            desc = "Comment Block",
        },
    },
    config = function()
        require("nvim-comment-frame").setup({
            disable_default_keymap = true,
            -- frame_width = 79,
            -- line_wrap_len = 76,
            languages = {
                python = {
                    frame_width = 61,
                    line_wrap_len = 52,
                    start_str = "# --",
                    end_str = "-- #",
                },
            },
        })
    end,
}
