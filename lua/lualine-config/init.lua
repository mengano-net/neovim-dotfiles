-- require('lualine').setup()
require('lualine').setup {
    options = {
        -- theme = 'onedark',
        -- theme = 'gruvbox',
        icons_enabled = true,
        -- extensions = {'fugitive'},
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_a = {
            'mode',
            -- 'buffers',
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
                -- sources = {"nvim_lsp"},
                symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            },
            'fileformat',
            'filetype',
        },
        lualine_y = {},
    }
}
