local telescope_builtin = require("telescope.builtin")
local telescope_utils = require("telescope.utils")
local themes = require("telescope.themes")

-- Return true if local directory is a clone of a git repository
local is_git_worktree = function()
    local _, ret, stderr = telescope_utils.get_os_command_output({
        "git",
        "rev-parse",
        "--is-inside-work-tree",
    })
    -- print(vim.inspect(ret))
    if ret == 0 then
        return true
    else
        return false
    end
end

local git_files = function()
    telescope_builtin.git_files({
        prompt_title = "Git Files",
        follow = "true",
        prompt_prefix = "  ",
    })
end

local find_files = function()
    if is_git_worktree() then
        git_files()
    else
        telescope_builtin.find_files()
    end
end

local grep_within_grep = function()
    telescope_builtin.grep_string({
        prompt_title = "Secondary Grep",
        search = vim.fn.input("Rg> "),
    })
end

local git_branches = function()
    if is_git_worktree() then
        telescope_builtin.git_branches({
            prompt_title = "Git Branches",
            prompt_prefix = "  ",
        })
    else
        -- vim.notify_once("Not a git working tree", 3, {})
        require("notify")("Not a git working tree", "WARN")
        return
    end
end

local git_commits = function()
    if is_git_worktree() then
        telescope_builtin.git_commits({
            prompt_title = "Git Commits",
            prompt_prefix = "  ",
        })
    else
        require("notify")("Not a git working tree", "WARN")
        return
    end
end

local git_bcommits = function()
    telescope_builtin.git_bcommits({
        prompt_title = "Commits which include current buffer",
        prompt_prefix = "  ",
    })
end

-- I do not use this, I usually explore within single project, and if I need to
-- explore to others, Telescope zoxide seems better
local find_files_in_path = function()
    local _path = vim.fn.input("Enter Directory: ", "", "dir")
    if _path == nil or _path == "" then
        _path = vim.fn.expand("%:p:h")
    end
    telescope_builtin.find_files(themes.get_ivy({
        prompt_title = "Find in directory: " .. _path,
        search_dirs = { _path },
    }))
end

local list_buffers = function()
    telescope_builtin.buffers(themes.get_dropdown({
        previewer = false,
        prompt_title = "Buffer List",
    }))
end

local recent_files = function()
    telescope_builtin.oldfiles(themes.get_dropdown({
        previewer = false,
        prompt_title = " Recent Files",
    }))
end

----------------------------------------------------------------------
--                  Telescope plugin configuration                  --
----------------------------------------------------------------------

return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        keys = {
            { "<leader>bl", list_buffers, desc = "( l )ist" },
            {
                "<leader>fz",
                "<cmd>lua require('telescope').extensions.zoxide.list()<cr>",
                desc = "( z )oxide",
            },
            {
                "<leader>fb",
                telescope_builtin.current_buffer_fuzzy_find,
                desc = "in ( b )uffer",
            },
            { "<leader>fc", telescope_builtin.grep_string, desc = "under ( c )ursor" },
            { "<leader>ff", find_files, desc = "( f )iles" },
            { "<leader>fg", grep_within_grep, desc = "( g )rep" },
            {
                "<leader>fj",
                telescope_builtin.jumplist,
                desc = "in ( j )ump list",
            },
            {
                "<leader>fs",
                telescope_builtin.live_grep,
                desc = "( s )tring",
            },
            {
                "<leader>fr",
                recent_files,
                desc = "( r )ecent files",
            },
            {
                "<leader>gd",
                telescope_builtin.lsp_definitions,
                desc = "( d )efinitions",
            },
            {
                "<leader>gr",
                telescope_builtin.lsp_references,
                desc = "( r )eferences",
            },
            {
                "<leader>Gb",
                git_branches,
                desc = "( b )ranches",
            },
            {
                "<leader>Gf",
                git_bcommits,
                desc = "( f )ile commits",
            },
            {
                "<leader>Gl",
                git_commits,
                desc = "( l )ist commits",
            },
            {
                "<leader>ls",
                telescope_builtin.lsp_document_symbols,
                desc = "( s )ymbols",
            },
            {
                "<leader>lt",
                telescope_builtin.lsp_type_definitions,
                desc = "( t )ypes",
            },
            {
                "<leader>vt",
                telescope_builtin.help_tags,
                desc = "Vim help ( t )ags",
            },
            {
                "<leader>vc",
                telescope_builtin.commands,
                desc = "Vim ( c )ommands",
            },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            -- TODO: I can't remember what these are for, if no purporse, remove
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
                    path_display = { "smart" },
                    selection_caret = " ",
                    set_env = { ["COLORTERM"] = "truecolor" },

                    -- Ideally, there would be a way to set a default theme for
                    -- telescope, there isn't. I'm trying one of these:
                    -- HACK: https://github.com/LazyVim/LazyVim/discussions/1127
                    -- HACK: https://github.com/nvim-telescope/telescope.nvim/issues/848
                    sorting_strategy = "ascending",
                    layout_strategy = "bottom_pane",
                    layout_config = {
                        height = 25,
                    },

                    border = true,
                    borderchars = {
                        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                        results = { " " },
                        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    },
                },
                extensions = {
                    fzf = { fuzzy = true },
                    zoxide = {
                        prompt_title = "[ Zoxide List ]",
                        mappings = {
                            default = {
                                after_action = function(selection)
                                    print(
                                        "Update to (" .. selection.z_score .. ") " .. selection.path
                                    )
                                end,
                            },
                            ["<C-s>"] = {
                                action = function(selection)
                                    vim.cmd("edit " .. selection.path)
                                end,
                            },
                            -- Opens the selected entry in a new split
                            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
                        },
                    },
                },
            })

            -- load_extension, somewhere after setup function:
            telescope.load_extension("fzf")
            telescope.load_extension("zoxide")
        end,
    },
    {
        "jvgrootveld/telescope-zoxide",
        dependencies = {
            "nvim-lua/popup.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
}
