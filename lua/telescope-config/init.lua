local actions = require('telescope.actions')

-- module export
local M = {}

-- Telescope's setup to instantiate and setup some defaults
require('telescope').setup {
  defaults = {
    layout_config = {
      width = 0.90,
      prompt_position = "bottom",
      preview_cutoff = 120,
      preview_width = 0.6,
      horizontal = {mirror = false},
      vertical = {mirror = false},
    },
    find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["q"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      }
    }
  }
}

-- mappings for Telescope
local map = vim.api.nvim_set_keymap

map('n', '<leader>f', ':lua require(\'telescope-extensions\').find_files()<cr>', {noremap = true, silent = true})
map('n', '<leader>gs', ':lua require(\'telescope.builtin\').grep_string()<cr>', {noremap = true, silent = true})
map('n', '<leader>lg', ':lua require(\'telescope.builtin\').live_grep()<cr>', {noremap = true, silent = true})
map('n', '<leader>gw', ':lua require(\'telescope-extensions\').grep_within_grep()<cr>', {noremap = true, silent = true})
map('n', '<leader>jl', ':lua require(\'telescope.builtin\').jumplist()<cr>', {noremap = true, silent = true})
map('n', '<leader>c', ':lua require(\'telescope.builtin\').commands()<cr>', {noremap = true, silent = true})
map('n', '<leader>ht', ':lua require(\'telescope.builtin\').help_tags()<cr>', {noremap = true, silent = true})
map('n', '<leader>nc', ':lua require(\'telescope-extensions\').neovim_config()<cr>', {noremap = true, silent = true})
map('n', '<leader>gc', ':lua require(\'telescope-extensions\').git_commits()<cr>', {noremap = true, silent = true})
map('n', '<leader>gb', ':lua require(\'telescope-extensions\').git_branches()<cr>', {noremap = true, silent = true})
