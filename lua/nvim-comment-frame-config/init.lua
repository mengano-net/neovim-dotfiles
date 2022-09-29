-- Exit if can't load module(s)
local status_ok, comment_frame = pcall(require, "nvim-comment-frame")
if not status_ok then
  print("Couldn't require module 'cmp'.")
  return
end

comment_frame.setup({
  disable_default_keymap = true,
  frame_width = 90,
  line_wrap_len = 80,
  languages = {
    python = {
      frame_width = 61,
      line_wrap_len = 52,
      start_str = '# --',
      end_str = '-- #',
    },
  }
})
