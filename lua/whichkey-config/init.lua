-- Exit if can't load module(s)
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  prefix = "<leader>",
  mode = "n", -- NORMAL mode
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local setup = {
  plugins = {
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    },
  },
  presets = {
    operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
  },
  window = {
    border = "rounded", -- none, single, double, shadow
  },
  layout = {
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
}

-- functions to toggle terminal windows, one floating, one horizontal
local Terminal = require("toggleterm.terminal").Terminal
local toggle_float = function ()
  local float = Terminal:new({direction = "float"})
  return float:toggle()
end
local toggle_horizontal = function ()
  local float = Terminal:new({direction = "horizontal"})
  return float:toggle()
end

-- Clearing some builtin maps that I will steal for my own.
vim.api.nvim_set_keymap("","s", "<Nop>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("","S", "<Nop>", {noremap = true, silent = true})

local mappings = {
  --[[ ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers{previewer = false, layout_config = {width = 0.5}}<cr>",
    "Buffers",
  }, ]]
  ["e"] = {
    name = "Edit",
    h = {"<cmd>nohl<cr>", "Highlights"},
    Y = {"y$", "Yank remainder of line"}
    -- p = {"<cmd>\"0p<cr>", "Paste previously yanked"}, -- this is not working for some reason
  },
  ["f"] = {"<cmd>lua require('telescope-extensions').find_files()<cr>", "Find Files" },
  ["g"] = {
    name = "Git",
    c = {"<cmd>lua require('telescope-extensions').git_commits()<cr>", "Commits"},
    b = {"<cmd>lua require('telescope-extensions').git_branches()<cr>", "Commits"},
  },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  ["s"] = {
    name = "Search",
    ["g"] = {":lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())<cr>", "Live Grep"},
    ["t"] = {":lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy())<cr>", "Tags"},
    ["j"] = {":lua require('telescope.builtin').jumplist(require('telescope.themes').get_ivy())<cr>", "Jump Points"},
    ["c"] = {":lua require('telescope.builtin').commands(require('telescope.themes').get_ivy())<cr>", "Commands"},
    -- t = {function() print("bar") end, "Foobar"}
  },
  ["t"] = {
    name = "Terminal",
    f = {toggle_float, "Floating"},
    h = {toggle_horizontal, "Horizontal"},
  },
  ["T"] = { "<cmd>NvimTreeToggle<cr>", "Nvim Tree" },
  ["x"] = {":bd!<cr>", "Close buffer"},
  ["w"] = {":w!<cr>", "Save buffer"},
}

which_key.setup(setup)
which_key.register(mappings, opts)
