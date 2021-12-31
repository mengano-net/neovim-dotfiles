-- Setup nvim-cmp.
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {prefix = '<leader>'}
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
  x = {":bd!<cr>", "Close buffer"},
  w = {":w<cr>", "Save buffer"},
  -- t = {
  --   name = "Terminal",
  --   f = {toggle_float, "Floating Terminal"},
  --   h = {toggle_float, "Horizontal Terminal"},
  -- },
}

wk.register(mappings, opts)
