require("user.options")
require("user.autommands")
require("user.mappings")
require("plugins")

--[[ local status_ok, darkplus = pcall(require, "darkplus")
if not status_ok then return end
vim.cmd("colorscheme darkplus") ]]

local status_ok, zenbones = pcall(require, "zenbones")
if not status_ok then return end
vim.cmd("colorscheme zenbones")
