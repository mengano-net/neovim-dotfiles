-- ⌾
-- ◉
-- ⭘
local M = {}

function M.eval()
    local file_path = vim.api.nvim_eval_statusline("%f", {}).str
    local modified = vim.api.nvim_eval_statusline("%M", {}).str == '+' and ' ◉' or ''

    file_path = file_path:gsub('/', ' ➤ ')

    vim.api.nvim_set_hl(0, 'WinBarCaps', { fg = '#dedede', bg = '#363636' })
    vim.api.nvim_set_hl(0, 'WinBarPath', { fg = '#363636', bg = '#dedede' })
    vim.api.nvim_set_hl(0, 'WinBarModified', { fg = '#ff3838' })

    return '%#WinBarCaps#'
        .. ''
        .. '%*'
        .. '%#WinBarPath#'
        .. file_path
        .. '%#WinBarCaps#'
        .. ''
        .. '%*'
        .. '%#WinBarModified#'
        .. modified
        .. '%*'
        .. "%#WinBar#"
        .. ' '
        .. '%*'
end

return M
