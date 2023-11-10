return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
        exclude = {
            filetypes = { "terminal", "help", "nofile", "NvimTree", },
            buftypes = { "packer", "help", "NvimTree", },
        }
    },
    event = "BufEnter",
}
