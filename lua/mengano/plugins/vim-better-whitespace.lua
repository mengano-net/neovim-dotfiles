return {
    "ntpeters/vim-better-whitespace",
    event = "BufEnter",
    config = function()
        vim.cmd( "let g:better_whitespace_filetypes_blacklist=['diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'fugitive', 'toggleterm']" )
    end,
}
