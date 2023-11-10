-- TODUA:
--

-- As per documentation, config is executed when the plugin loads. The
-- default implementation will automatically run require(MAIN).setup(opts)
-- thus no need to run: config =  function() require('telescope').setup({}) end,
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opt = {
            defaults = {
                file_ignore_patterns = { ".git", "node_modules" },
                -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                find_command = {
                    "rg",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                initial_mode = "insert",
                prompt_prefix = " ",
                path_display = { "smart" },
                selection_caret = " ",
                set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            },
            extensions = {
                fzf = { fuzzy = false },
                zoxide = {
                    prompt_title = "[ Zoxide List ]",
                    mappings = {
                        default = {
                            after_action = function(selection)
                                print("Update to (" .. selection.z_score .. ") " .. selection.path)
                            end
                        },
                        ["<C-s>"] = {
                            before_action = function(selection) print("before C-s") end,
                            action = function(selection)
                                vim.cmd("edit " .. selection.path)
                            end
                        },
                        -- Opens the selected entry in a new split
                        -- ["<C-q>"] = { action = z_utils.create_basic_command("split") },
                    },
                }
            }
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "jvgrootveld/telescope-zoxide",
        dependencies = { "nvim-lua/popup.nvim", "nvim-telescope/telescope.nvim" },
    },
}
