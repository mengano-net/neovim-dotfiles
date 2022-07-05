-- Exit if can't load module
local status_ok, blankline = pcall(require, "indent_blankline")
if not status_ok then
  return
end

vim.opt.listchars:append("eol:↴")

blankline.setup {
  buftype_exclude = { "terminal", "help", "nofile", "NvimTree" },
  filetype_exclude = { "packer", "help", "NvimTree" },
  show_current_context_start = true,
  show_end_of_line = true,
  show_icons = {
    git = 1,
  },
}
