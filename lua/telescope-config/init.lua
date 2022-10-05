-- Exit if can't load module
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print("Couldn't require module 'telescope'.")
  return
end

local actions = require("telescope.actions")
-- Useful for easily creating commands
local z_utils = require("telescope._extensions.zoxide.utils")

-- Telescope's setup to instantiate and setup some defaults
telescope.setup({
  defaults = {
    file_ignore_patterns = { ".git", "node_modules" },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    find_command = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    initial_mode = "insert",
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center,
      },
      n = {
        ["q"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["?"] = actions.which_key,
      },
    },
    prompt_prefix = " ",
    path_display = { "smart" },
    selection_caret = " ",
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
  extensions = {
    fzf = { fuzzy = false },
    zoxide = {
      prompt_title = "[ Walking on the shoulders of TJ ]",
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
        ["<C-q>"] = { action = z_utils.create_basic_command("split") },
      },
    }
  }
})

-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require("telescope").load_extension('zoxide')
