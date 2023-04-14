-- Exit if can't load module
local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

treesitter.setup {
    autopairs = { enable = true },
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = { "vim", "vimdoc", "lua", "bash", "markdown", "python" },
    auto_install = true, -- See comments on github
    sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
    ignore_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- See comments on github
    },
    incremental_selection = { enable = true },
    indent = { enable = true },
    playground = { enable = true },
    rainbow = {
        enable = true,
        -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        extended_mode = false,
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
}
