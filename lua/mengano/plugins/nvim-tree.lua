return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            actions = {
                open_file = { quit_on_open = true, resize_window = true },
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                icons = {
                    hint = " ",
                    info = " ",
                    warning = " ",
                    error = " ",
                },
            },
            disable_netrw = true,
            filters = { dotfiles = true },
            git = {},
            reload_on_bufenter = true,
            renderer = {
                add_trailing = true,
                indent_markers = { enable = false },
                highlight_opened_files = "all",
                highlight_git = true,
                icons = {
                    padding = " ",
                    glyphs = {
                        git = {
                            unstaged = "",
                            staged = "S",
                            unmerged = "",
                            renamed = "➜",
                            deleted = "",
                            untracked = "U",
                            ignored = "◌",
                        },
                    },
                },
            },
            sync_root_with_cwd = true,
            view = { adaptive_size = true },
        })
    end,
}
