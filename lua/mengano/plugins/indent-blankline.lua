return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = "BufEnter",
    config = function()
        require("ibl").setup({
            exclude = {
                filetypes = { "terminal", "help", "nofile", "NvimTree", },
                buftypes = { "packer", "help", "NvimTree", },
            }
        })
    end,
}
