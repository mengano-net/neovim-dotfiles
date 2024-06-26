return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = { "p00f/nvim-ts-rainbow" },
        opts = {
            autopairs = { enable = true },
            ensure_installed = {
                "vimdoc",
                "lua",
                "bash",
                "markdown",
                "markdown_inline",
                "python",
                "toml",
                "yaml",
            },
            auto_install = true,
            sync_install = false,
            ignore_install = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = { enable = true },
            indent = { enable = true },
            playground = { enable = true },
            rainbow = {
                enable = true,
                -- Also highlight non-bracket delimiters like html tags,
                -- boolean or table: lang -> boolean
                extended_mode = false,
                -- Do not enable for files with more than n lines, int
                max_file_lines = nil,
            },
        },
    },
}
