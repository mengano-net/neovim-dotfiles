-- Firstly, let's clear any possible existing maps set on "<Space>"
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.leader = " "

-- Other variables, helper functions
local spell_file = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"

local function is_file_readable(file_path)
    if vim.fn.empty(vim.fn.glob(file_path)) > 0 then
        return false
    else
        return true
    end
end

local function create_spellfile(file_path)
    local ok, fd = pcall(vim.loop.fs_open, file_path, "w", 420)
    if not ok then
        require("notify")("Couldn't create spell file: " .. file_path, "error", {})
    end
end

local global_options = {
    autoindent = true,
    autoread = true,
    autowrite = true,
    background = "dark",
    backspace = "indent,eol,start",
    backup = false,
    breakindent = true,
    breakindentopt = "shift:2",
    clipboard = "unnamedplus",
    cmdheight = 1,
    colorcolumn = "80",
    conceallevel = 0,
    completeopt = "menu,menuone,preview,noselect,noinsert",
    cul = true,
    cuc = false,
    dictionary = "/usr/share/dict/words",
    diffopt = { "filler", "internal", "algorithm:histogram", "indent-heuristic" },
    expandtab = true,
    shiftround = true,
    fileencoding = "utf-8",
    hidden = true,
    hlsearch = true,
    incsearch = true,
    ignorecase = false,
    laststatus = 2,
    list = true,
    number = true,
    mouse = "n",
    ruler = true,
    swapfile = false,
    -- pastetoggle = "<F2>",
    pumheight = 20,
    redrawtime = 250,
    relativenumber = true,
    showcmd = false,
    showmode = false,
    spell = false,
    smartcase = true,
    scrolloff = 5,
    shiftwidth = 4,
    signcolumn = "yes:2",
    sidescrolloff = 5,
    softtabstop = 4,
    splitright = true,
    splitbelow = true,
    showbreak = "↳",
    termguicolors = true,
    tabstop = 4,
    textwidth = 80,
    timeoutlen = 1000,
    updatetime = 150,
    undofile = true,
    undodir = os.getenv("HOME") .. "/.cache/nvim/undodir",
    wrap = true,
    writebackup = false,
    wildoptions = "pum",
    wildmenu = true,
}

for key, value in pairs(global_options) do
    vim.opt[key] = value
end

if not is_file_readable(spell_file) then
    create_spellfile(spell_file)
end
vim.opt.spellfile = spell_file

vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-,_")
vim.opt.listchars:append("eol:↴")

local buffer_options = {
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
}

for key, value in pairs(buffer_options) do
    vim.bo[key] = value
end

-- Disabling some of vim's built-in plugins I do not use
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
