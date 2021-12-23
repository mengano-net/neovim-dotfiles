-- skip if module(s) isn't loaded
local status_ok, notify = pcall(require, "notify")
if not status_ok then
  return
end

local M = {}

-- function M.notify(msg, stage, opts)
--   require("notify")(vim.inspect(msg), vim.inspect(stage), {
--     title = vim.inspect(title),
--     timeout = 100,
--   })
-- end

-- this worked on cli
-- lua require("notify")("message", "debug", {title = "title"})
-- lua require('notify-extensions').notify("title", "message", 3, 5000)

-- from help
-- notify.notify({message}, {level}, {opts})                    *notify.notify()*

function M.notify(title, msg, log_level, time_out)
  local opts = {
    title = vim.inspect(title),
    timeout = time_out,
  }
  notify(vim.inspect(msg), log_level, opts)
end

-- Adding module to the _G global variable.
_G.utils = M
return M
