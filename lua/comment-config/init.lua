-- skip if module(s) isn't loaded
local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup{
  ignore = '^$'
}
