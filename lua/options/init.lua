vim.g.mapleader = ' '
vim.g.leader = ' '

vim.cmd[[
syntax enable
filetype plugin indent on

augroup highlight_on_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=750}
augroup END

" Unset paste mode aboue on InsertLeave action, that is leaving insert mode
autocmd InsertLeave * silent! set nopaste

" Spelling mistakes will be colored up red
hi SpellBad cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellLocal cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellRare cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellCap cterm=underline ctermfg=203 guifg=#ff5f5f

" No lines on terminal window, also go stright into insert mode
au TermOpen * silent! setlocal nonumber norelativenumber
au TermOpen * silent! startinsert

" Saw this online while troubleshooting LSP
" autocmd CursorHold,CursorHoldI * lua require('code_action_utils').code_action_listener()

]]

vim.o.smartcase = true
vim.o.laststatus = 2
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = false
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.o.ruler = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.pastetoggle = '<F2>'
vim.o.backspace = 'indent,eol,start'
vim.o.showcmd = false
vim.o.showmode = false
vim.o.wildoptions = 'pum'
vim.o.wildignore = vim.o.wildignore .. '*.swp,.git,.gitignore'
vim.o.path = vim.o.path .. '.,**,'
vim.o.hidden = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.wildmenu = true
vim.o.redrawtime = 250
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
vim.o.textwidth = 99
vim.o.updatetime = 150
vim.o.backup = false
vim.o.timeoutlen = 1000
vim.o.list = true
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cul = true
vim.o.cuc = true
vim.o.colorcolumn = '100'
vim.o.signcolumn = 'yes:2'
vim.o.clipboard = "unnamedplus"
-- vim.o.mouse = "a"      -- mouse support
vim.o.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
-- not neededing since I'm running plugin: akinsho/bufferline.nvim
-- vim.o.showtabline = 2
