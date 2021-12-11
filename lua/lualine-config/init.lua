local function current_buffer_number()
  return "﬘ " .. vim.api.nvim_get_current_buf()
end

local function current_date()
  return string.sub(os.date "%x", 1, 5)
end

-- Vim's working directory
local function current_working_dir()
  local cwd = string.sub(vim.fn.getcwd(), 12)
  return "~" .. cwd
end

require('lualine').setup {
  options = {
    theme = 'onedark',
    -- theme = 'rose-pine',
    icons_enabled = true,
    extensions = {'fugitive'},
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {
      'mode',
    },
    lualine_b = {
      'branch',
      'diff',
    },
    lualine_c = {
      {
        'filename',           -- displays file status (readonly status, modified status)
        file_status = true,   -- 0 = just filename, 1 = relative path, 2 = absolute path
        path = 1,             -- Shortens path to leave 40 space in the window
      }
    },
    lualine_x = {
      {
        'diagnostics',
        sources = {"nvim_diagnostic"},
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
      },
      -- 'fileformat',
      'filetype',
      -- { "filetype", icon_only = true },
    },
    -- lualine_y = {},
    lualine_y = { { current_buffer_number }, { current_date } },
  }
}
