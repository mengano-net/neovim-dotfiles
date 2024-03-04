-- Clearing some builtin maps that I will steal for my own
vim.keymap.set("", "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "S", "<Nop>", { noremap = true, silent = true })

----------------------------------------------------------------------
--                Configuration for whichkey plugin                 --
----------------------------------------------------------------------

local opts = {
    prefix = "<leader>",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local mappings = {
    b = { name = "Buffers" },
    e = {
        name = "Edit",
        h = { "<cmd>nohl<cr>", "No Highlights" },
        r = { "<cmd>retab<cr>", "Retab" },
    },
    g = {
        name = "Goto",
        j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
    },
    G = { name = "Git" },
    h = { name = "Hunks" },
    l = {
        name = "LSP",
        h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Definition" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable" },
    },
    s = { name = "Search" },
    t = { name = "Terminal" },
    T = { "<cmd>NvimTreeToggle<cr>", "Nvim Tree" },
    x = { ":bd!<cr>", "Destroy buffer" },
    w = { ":w!<cr>", "Save buffer" },
}

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    config = function()
        require("which-key").setup({
            window = {
                border = "single",
                margin = { 0, 0, 0, 0 },
                padding = { 0, 0, 0, 0 },
            },
            layout = { align = "center" },
        })
        require("which-key").register(mappings, opts)
    end,
}
