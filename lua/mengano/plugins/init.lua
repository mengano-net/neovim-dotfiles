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
        ft = "markdown",
        config = function()
            vim.g.nvim_markdown_preview_theme = 'solarized-dark'
        end
    },
    {
        "s1n7ax/nvim-comment-frame",
        dependencies = { "nvim-treesitter" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-comment-frame").setup({
                disable_default_keymap = true,
                -- frame_width = 79,
                -- line_wrap_len = 76,
                languages = {
                    python = {
                        frame_width = 61,
                        line_wrap_len = 52,
                        start_str = '# --',
                        end_str = '-- #',
                    }
                }
            })
        end,
    },
    {
        "j-hui/fidget.nvim", event = "VeryLazy", opts = {},
    },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            require('neoscroll').setup()
        end
    },
    {
        "jinh0/eyeliner.nvim",
        event = "VeryLazy",
        config = function()
            require 'eyeliner'.setup { highlight_on_key = true, dim = true }
        end
    },
    {
        "DanilaMihailov/beacon.nvim",
    },
    {
        "rcarriga/nvim-notify",
    }
}
