-- For plugins that need no lengthy configrations
return {
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    { "norcalli/nvim-colorizer.lua" },
    {
        "ntpeters/vim-better-whitespace",
        event = "BufEnter",
        config = function()
            vim.cmd(
                "let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive', 'toggleterm']")
        end,
    },
    { "tpope/vim-fugitive" },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufEnter",
        opts = {
            exclude = {
                filetypes = { "terminal", "help", "nofile", "NvimTree", },
                buftypes = { "packer", "help", "NvimTree", },
            }
        },
    },
    {
        "davidgranstrom/nvim-markdown-preview",
    },
}
