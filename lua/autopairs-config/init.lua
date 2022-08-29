-- Exit if can't load module
local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then return end

autopairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
})

-- If you use cmp, need this as per documentation, inside if-then in case module is not loaded.
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")

local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not cmp_autopairs_ok then return end

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

---@cast cmp -?
-- See https://github.com/sumneko/lua-language-server/issues/1487
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
