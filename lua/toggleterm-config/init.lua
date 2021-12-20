-- skip if module(s) isn't loaded
local status_ok, comment = pcall(require, "toggleterm")
if not status_ok then
  return
end

require("toggleterm").setup {
  open_mapping = [[<leader>sh]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  persist_size = true,
  direction = 'horizontal',
  shell = "zsh"
}
