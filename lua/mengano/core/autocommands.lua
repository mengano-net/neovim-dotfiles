----------------------------------------------------------------------
--                        Autocommand groups                        --
----------------------------------------------------------------------
local _general = vim.api.nvim_create_augroup("general_settings", { clear = true })
local _git = vim.api.nvim_create_augroup("git", { clear = true })
local _python = vim.api.nvim_create_augroup("python", { clear = true })
local _documentation = vim.api.nvim_create_augroup("documentation", { clear = true })
local _yaml = vim.api.nvim_create_augroup("yaml", { clear = true })
local _terminal = vim.api.nvim_create_augroup("terminal", { clear = true })
local _markdown = vim.api.nvim_create_augroup("terminal", { clear = true })

----------------------------------------------------------------------
--                      'General' autocommands                      --
----------------------------------------------------------------------

vim.api.nvim_create_autocmd("TextYankPost", {
    group = _general,
    command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=500}",
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = _general,
    command = "silent! set nopaste",
})

-- Setting up winbar
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = _general,
    pattern = "*",
    callback = function()
        if
            vim.bo.filetype == ""
            or vim.bo.filetype == "NvimTree"
            or vim.bo.filetype == "fugitive"
            or vim.bo.filetype == "gitcommit"
            or vim.bo.filetype == "help"
            or vim.bo.filetype == "toggleterm"
        then
            vim.wo.winbar = ""
        else
            vim.wo.winbar = "%{%v:lua.require('mengano.core/winbar').eval()%}"
        end
    end,
})

----------------------------------------------------------------------
--                               Git                                --
----------------------------------------------------------------------
local function filetypes_git()
    vim.cmd("setlocal spell spelllang=en_us")
    vim.cmd("startinsert | 1")
end

vim.api.nvim_create_autocmd("FileType", {
    group = _git,
    pattern = { "gitcommit", "gitrebase" },
    -- command = "startinsert | 1",
    callback = filetypes_git,
})

----------------------------------------------------------------------
--                           Python files                           --
----------------------------------------------------------------------
local function filetypes_python() vim.opt_local.colorcolumn = "80" end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    group = _python,
    pattern = { "*.py" },
    callback = filetypes_python,
})

----------------------------------------------------------------------
--                     Documentation file types                     --
----------------------------------------------------------------------
local documentation_file_options = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.spell = true
    vim.bo.fo = "awtq"
    vim.opt_local.linebreak = true
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = _documentation,
    pattern = { "*.md", "*.tex" },
    callback = documentation_file_options,
})

----------------------------------------------------------------------
--                               Yaml                               --
----------------------------------------------------------------------
local yaml_file_options = function()
    -- vim.cmd "TSBufDisable highlight"
    -- vim.api.nvim_set_hl(0, "yamlTSField", { fg = '#569cd6', bg = 'NONE' })
    -- vim.api.nvim_set_hl(0, "yamlBlockMappingKey", { fg = '#00dfff', bg = 'NONE' })
    -- vim.cmd "TSBufEnable highlight"
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = _yaml,
    pattern = { "*.yaml", "*.yml" },
    callback = yaml_file_options,
})

----------------------------------------------------------------------
--                               Markdown                           --
----------------------------------------------------------------------
local markdown_file_options = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
end

vim.api.nvim_create_autocmd("BufEnter", {
    group = _markdown,
    pattern = { "*.md" },
    callback = markdown_file_options,
})

----------------------------------------------------------------------
--                                       Terminal                   --
----------------------------------------------------------------------
local terminal = function()
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], { silent = true })
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { silent = true })
end

vim.api.nvim_create_autocmd("TermOpen", {
    group = _terminal,
    pattern = { "term://*" },
    callback = terminal,
})
