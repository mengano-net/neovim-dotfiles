-- Exit if can't load module(s)
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

local function current_buffer_number() return "﬘ " .. vim.api.nvim_get_current_buf() end

local function current_date()
  -- return string.sub(os.date "%x", 1, 5)
  -- return os.date "%x"
  return os.date("%a %b %d, %H:%M", os.time() + 1 * 60 * 60)
end

-- Vim's working directory
local function current_working_dir()
  local cwd = string.sub(vim.fn.getcwd(), 0)
  return "~" .. cwd
end

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars =
  { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local function word_count() return "Words: " .. tostring(vim.fn.wordcount().words) end

lualine.setup({
  options = {
    component_separators = " ",
    disabled_filetypes = {
      "NvimTree",
      "Outline",
      "toggleterm",
      "gitcommit",
      "help",
      "lspinfo",
      "man",
      "qf",
    },
    extensions = { "fugitive" },
    icons_enabled = true,
    section_separators = " ",
    theme = "tokyonight",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      { "branch", icon = "" },
      {
        "diff",
        colored = true,
        diff_color = {
          added    = 'DiffAdd', -- Changes the diff's added color
          modified = 'DiffChange', -- Changes the diff's modified color
          removed  = 'DiffDelete', -- Changes the diff's removed color you
        },
        padding = { left = 1, right = 2 },
      },
    },
    lualine_c = {
      {
        "filename", -- displays file status (readonly status, modified status)
        -- current_working_dir,
        file_status = true, -- 0 = just filename, 1 = relative path, 2 = absolute path
        path = 1, -- Shortens path to leave 40 space in the window
      },
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      -- 'fileformat',
      "filetype",
      -- { "filetype", icon_only = true },
    },
    lualine_y = { word_count, "location", progress },
    lualine_z = { current_date },
  },
})
