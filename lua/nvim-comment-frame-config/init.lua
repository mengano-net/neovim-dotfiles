-- Exit if can't load module(s)
local status_ok, comment_frame = pcall(require, "nvim-comment-frame")
if not status_ok then
  print("Couldn't require module 'cmp'.")
  return
end

comment_frame.setup({
  disable_default_keymap = true,
})
