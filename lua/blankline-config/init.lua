-- Exit if can't load module
local status_ok, comment = pcall(require, "indent_blankline")
if not status_ok then
  return
end

require("indent_blankline").setup {
  buftype_exclude = {"terminal", "help"},
  filetype_exclude = {"packer", "help"},
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true,
}
