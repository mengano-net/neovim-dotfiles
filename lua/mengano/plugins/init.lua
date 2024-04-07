----------------------------------------------------------------------
--          For plugins that need no lengthy configuration          --
----------------------------------------------------------------------

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
                "let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive', 'toggleterm']"
            )
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufEnter",
        opts = {
            exclude = {
                filetypes = { "terminal", "help", "nofile", "NvimTree" },
                buftypes = { "packer", "help", "NvimTree" },
            },
        },
    },
    {
        "davidgranstrom/nvim-markdown-preview",
        ft = "markdown",
        config = function() vim.g.nvim_markdown_preview_theme = "solarized-dark" end,
    },
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function() require("neoscroll").setup() end,
    },
    {
        "jinh0/eyeliner.nvim",
        event = "VeryLazy",
        config = function() require("eyeliner").setup({ highlight_on_key = true, dim = true }) end,
    },
    {
        "DanilaMihailov/beacon.nvim",
    },
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function() require("notify").setup() end,
    },
    {
        "tpope/vim-surround",
    },
}
