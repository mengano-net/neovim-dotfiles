-- Setup nvim-cmp.
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local mappings = {
  x = {":bd!<cr>", "Close buffer"},
  w = {":w<cr>", "Save buffer"},
}
local opts = {prefix = '<leader>'}

wk.register(mappings, opts)
