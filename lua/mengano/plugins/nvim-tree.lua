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
                    -- 
                    info = " ",
                    warning = " ",
                    error = " ",
                },
            },
            git = {
                enable = true,
            },
            disable_netrw = true,
            filters = { dotfiles = true },
            reload_on_bufenter = true,
            renderer = {
                add_trailing = true,
                highlight_opened_files = "all",
                highlight_git = "icon",
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
        vim.keymap.set(
            { "n" },
            "<leader>ee",
            "<cmd>NvimTreeToggle<cr>",
            { desc = "( e )xplorer" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>ef",
            "<cmd>NvimTreeFindFileToggle<cr>",
            { desc = "( f )ile current" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>ec",
            "<cmd>NvimTreeCollapse<cr>",
            { desc = "( c )ollapse" }
        )
        vim.keymap.set(
            { "n" },
            "<leader>er",
            "<cmd>NvimTreeRefresh<cr>",
            { desc = "( r )efresh" }
        )
    end,
}
