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
    --[[ local opts = {
    prompt_title = "\\ Git Files /",
    follow = 'true',
    -- hidden = 'false',
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
    },
  }
  require'telescope.builtin'.git_files(opts) ]]
    telescope_builtin.git_files(themes.get_ivy({
        prompt_title = "Git Files",
        follow = "true",
        prompt_prefix = "  ",
    }))
end

local find_files = function()
    if is_git_worktree() then
        git_files()
    else
        telescope_builtin.find_files(themes.get_ivy({}))
    end
end

local live_grep = function() telescope_builtin.live_grep(themes.get_ivy()) end

local grep_within_grep = function()
    telescope_builtin.grep_string(themes.get_ivy({
        prompt_title = "Secondary Grep",
        search = vim.fn.input("Rg> "),
    }))
end

local git_branches = function()
    --[[ local opts = {
    prompt_title = "\\ Git Branches /",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
    },
    prompt_prefix = '  ',
  } ]]
    if is_git_worktree() then
        telescope_builtin.git_branches(themes.get_ivy({
            prompt_title = "Git Branches",
            prompt_prefix = "  ",
        }))
    else
        -- vim.notify_once("Not a git working tree", 3, {})
        require("notify")("Not a git working tree", "WARN")
        return
    end
end

local git_commits = function()
    if is_git_worktree() then
        telescope_builtin.git_commits(themes.get_ivy({
            prompt_title = "Git Commits",
            prompt_prefix = "  ",
        }))
    else
        require("notify")("Not a git working tree", "WARN")
        return
    end
end

local git_bcommits = function()
    telescope_builtin.git_bcommits(themes.get_ivy({
        prompt_title = "Commits which include current buffer",
        prompt_prefix = "  ",
    }))
end

local find_files_in_path = function()
    local _path = vim.fn.input("Enter Directory: ", "", "dir")
    if _path == nil or _path == "" then _path = vim.fn.expand("%:p:h") end
    telescope_builtin.find_files(themes.get_ivy({
        prompt_title = "Find in directory: " .. _path,
        search_dirs = { _path },
    }))
end

local list_buffers = function()
    telescope_builtin.buffers(themes.get_ivy({
        previewer = false,
        prompt_title = "Open Buffers",
    }))
end

local jump_list = function() telescope_builtin.jumplist(themes.get_ivy({})) end

local recent_files = function() telescope_builtin.oldfiles(themes.get_ivy({ previewer = false })) end

local zoxide_list = function() require("telescope").extensions.zoxide.list(themes.get_ivy({})) end

local symbols = function() telescope_builtin.lsp_document_symbols(themes.get_ivy()) end

local search_tags = function() telescope_builtin.help_tags(themes.get_ivy()) end

local search_commands = function() telescope_builtin.commands(themes.get_ivy()) end

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
                cond = function() return vim.fn.executable("make") == 1 end,
            },
        },
        keys = {
            { "<leader>bl", list_buffers, desc = "Buffers" },
            { "<leader>f", find_files, desc = "Find files" },
            { "<leader>F", find_files_in_path, desc = "Find files in path ..." },
            { "<leader>gJ", jump_list, desc = "Jump list" },
            { "<leader>gr", recent_files, desc = "Recent files" },
            { "<leader>gz", zoxide_list, desc = "Zoxide jump list" },
            { "<leader>Gb", git_branches, desc = "Branches" },
            { "<leader>Gf", git_bcommits, desc = "File Commit List" },
            { "<leader>Gl", git_commits, desc = "Commits" },
            { "<leader>ls", symbols, desc = "Symbols" },
            { "<leader>sg", live_grep, desc = "Grep" },
            { "<leader>sG", grep_within_grep, desc = "Grep within grep ..." },
            { "<leader>st", search_tags, desc = "Tags" },
            { "<leader>sc", search_commands, desc = "Commands" },
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
                                    print(
                                        "Update to (" .. selection.z_score .. ") " .. selection.path
                                    )
                                end,
                            },
                            ["<C-s>"] = {
                                action = function(selection) vim.cmd("edit " .. selection.path) end,
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
