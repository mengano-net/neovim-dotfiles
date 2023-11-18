-- TODUA:

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            -- local file_previewer = require("telescope.previewers").vim_buffer_cat.new
            -- local generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter
            local z_utils = require("telescope._extensions.zoxide.utils")

            telescope.setup({
                defaults = {
                    file_ignore_patterns = { ".git", "node_modules" },
                    find_command = {
                        "rg",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    initial_mode = "insert",
                    mappings = {
                        i = {
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_default + actions.center,
                        },
                        n = {
                            ["q"] = actions.close,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                            ["?"] = actions.which_key,
                        },
                    },
                    prompt_prefix = " ",
                    path_display = { "truncate" },
                    selection_caret = " ",
                    set_env = { ["COLORTERM"] = "truecolor" },
                },
                extensions = {
                    fzf = { fuzzy = true },
                    zoxide = {
                        prompt_title = "[ Zoxide List ]",
                        mappings = {
                            default = {
                                after_action = function(selection)
                                    print("Update to (" .. selection.z_score .. ") " .. selection.path)
                                end
                            },
                            ["<C-s>"] = {
                                action = function(selection)
                                    vim.cmd("edit " .. selection.path)
                                end
                            },
                            -- Opens the selected entry in a new split
                            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
                        },
                    }
                },
            })

            -- load_extension, somewhere after setup function:
            -- telescope.load_extension("fzf")
            telescope.load_extension("zoxide")
        end,
    },
    {
        "jvgrootveld/telescope-zoxide",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope.nvim"
        },
    },
}
