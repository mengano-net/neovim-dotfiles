-- Exit if can't load module(s)
-- local status_ok, format = pcall(require, "format")
-- if not status_ok then
--   return
-- end

-- format.setup {
require("format").setup {
  html = {{cmd = {"prettier -w"}}},
  css = {{cmd = {"prettier -w"}}},
  json = {{cmd = {"prettier -w"}}},
  yaml = {{cmd = {"prettier -w"}}},
}
