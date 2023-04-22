-- vim.o.winbar = '%f'
-- '⌾'
-- '◉'
-- '➤'
-- ''
-- ''
local M = {}

function M.eval()
    local file_path = vim.api.nvim_eval_statusline("%f", {}).str
    local modified = vim.api.nvim_eval_statusline("%M", {}).str == '+' and ' ⭘ ' or ''

    file_path = file_path:gsub('/', ' ➤ ')

    -- '%#WinBar#'
    -- .. '%*'
    return ' '
        .. file_path
        .. ' '
        .. modified
end

return M
