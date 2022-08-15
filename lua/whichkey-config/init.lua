--  if can't load module(s)
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
local toggle_float = function()
  local float = Terminal:new({ direction = "float" })
  return float:toggle()
end
local toggle_horizontal = function()
  local float = Terminal:new({ direction = "horizontal" })
  return float:toggle()
end

-- Clearing some builtin maps that I will steal for my own.
vim.api.nvim_set_keymap("", "s", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("", "S", "<Nop>", { noremap = true, silent = true })

local mappings = {
  ["b"] = {
    name = "Buffers",
    l = {
      "<cmd>lua require('telescope.builtin').buffers{previewer = false, layout_config = {width = 0.5}}<cr>",
      "List",
    },
  },
  ["e"] = {
    name = "Edit",
    h = { "<cmd>nohl<cr>", "No Highlights" },
    -- p = {"<cmd>\"0p<cr>", "Paste previously yanked"}, -- this is not working for some reason
  },
  ["f"] = { "<cmd>lua require('user.telescope').find_files()<cr>", "Find Files" },
  ["F"] = {
    name = "Find",
    ["f"] = {
      ":lua require('user.telescope').find_files_in_path()<cr>",
      "Files in directory",
    },
    r = { ":%s///g<left><left><left>", "Replace Globally" },
    c = { ":%s///gc<left><left><left>", "Replace / Confirm" },
  },
  ["g"] = {
    name = "Goto",
    j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
    ["J"] = {
      ":lua require('telescope.builtin').jumplist(require('telescope.themes').get_ivy())<cr>",
      "Jump Points",
    },
  },
  ["G"] = {
    name = "Git",
    b = { "<cmd>lua require('user.telescope').git_branches()<cr>", "Branches" },
    c = { "<cmd>Git commit -s<cr>", "Commit" },
    -- h = {},
    l = { "<cmd>lua require('user.telescope').git_commits()<cr>", "List commits" },
    s = { "<cmd>Ge:<cr>", "Stage?" },
    S = { "<cmd> Gitsigns stage_buffer<cr>", "Stage Buffer" },
    p = { "<cmd>Git pull<cr>", "Pull" },
    P = { "<cmd>Git push<cr>", "Push" },
    r = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
  },
  ["h"] = {
    name = "Hunks",
    b = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", "Blame Line" },
    j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    s = { "<cmd> Gitsigns stage_hunk<cr>", "Stage Hunk" },
    u = { "<cmd Gitsigns undo_stage_hunk<cr>", "UnStage Hunk" },
  },
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["s"] = {
    name = "Search",
    ["g"] = {
      -- ":lua require('telescope.builtin').live_grep({require('telescope.themes').get_ivy(), search_dirs = {_path})<cr>",
      ":lua require('telescope.builtin').live_grep({require('telescope.themes').get_ivy()})<cr>",
      "Live Grep",
    },
    ["t"] = {
      ":lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy())<cr>",
      "Help Tags",
    },
    ["c"] = {
      ":lua require('telescope.builtin').commands(require('telescope.themes').get_ivy())<cr>",
      "Commands",
    },
    ["G"] = { "<cmd>lua require('user.telescope').grep_within_grep()<cr>", "Grep within grep" },
    ["m"] = {
      ":lua require('telescope.builtin').man_pages(require('telescope.themes').get_ivy())<cr>",
      "Man Pages",
    },
    ["r"] = {
      ":lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy())<cr>",
      "Recent Files",
    },
    -- t = {function() print("bar") end, "Foobar"}
  },
  -- I'm using the built-in map <C-\> to toggle terminal
  -- ["t"] = { "<cmd>ToggleTerm<cr>", "Terminal" },
  -- ["t"] = {
  -- 	name = "Terminal",
  -- 	f = { toggle_float, "Floating" },
  -- 	h = { toggle_horizontal, "Horizontal" },
  -- },
  ["T"] = { "<cmd>NvimTreeToggle<cr>", "Nvim Tree" },
  ["x"] = { ":bd!<cr>", "Close buffer" },
  ["w"] = { ":w!<cr>", "Save buffer" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
