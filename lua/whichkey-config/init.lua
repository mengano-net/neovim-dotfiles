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

local mappings = {
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers{previewer = false}<cr>",
    "Buffers",
  },
  ["e"] = {
    name = "Edit",
    h = {"<cmd>nohl<cr>", "Highlights"},
    -- p = {"<cmd>\"0p<cr>", "Paste previously yanked"}, -- this is not working for some reason
  },
  -- ["E"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  ["t"] = {
    name = "Terminal",
    f = {toggle_float, "Floating"},
    h = {toggle_horizontal, "Horizontal"},
  },
  ["x"] = {":bd!<cr>", "Close buffer"},
  ["w"] = {":w!<cr>", "Save buffer"},
}

which_key.setup(setup)
which_key.register(mappings, opts)
