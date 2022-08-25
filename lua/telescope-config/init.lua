-- Exit if can't load module
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end

local themes = require("telescope.themes")
local actions = require("telescope.actions")
local map = vim.api.nvim_set_keymap

-- Telescope's setup to instantiate and setup some defaults
telescope.setup({
  defaults = {
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    entry_prefix = "  ",
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = {},
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
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.90,
      prompt_position = "bottom",
      preview_cutoff = 120,
      preview_width = 0.6,
      horizontal = { mirror = false },
      vertical = { mirror = false },
    },
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
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    selection_caret = " ",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    winblend = 0,
  },
})

-- mappings for Telescope
-- map('n', '<leader>nc', ':lua require(\'user.telescope\').neovim_config()<cr>', {noremap = true, silent = true})
