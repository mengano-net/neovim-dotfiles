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
    b = {
        name = "Buffers",
    },
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
    G = {
        name = "Git",
        B = { "<cmd>lua require('gitsigns').blame_line{full=false}<cr>", "Blame" },
        c = { "<cmd>Git commit -s<cr>", "Commit" },
        s = { "<cmd>Ge:<cr>", "Status" },
        S = { "<cmd> Gitsigns stage_buffer<cr>", "Stage Buffer" },
        p = { "<cmd>Git pull<cr>", "Pull" },
        P = { "<cmd>Git push<cr>", "Push" },
        r = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    },
    h = {
        name = "Hunks",
        b = { "<cmd>lua require'gitsigns'.blame_line{full=false}<cr>", "Blame Line - Short" },
        B = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", "Blame Line - Short" },
        j = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
        k = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
        p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
        r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
        s = { "<cmd> Gitsigns stage_hunk<cr>", "Stage Hunk" },
        u = { "<cmd Gitsigns undo_stage_hunk<cr>", "UnStage Hunk" },
    },
    l = {
        name = "LSP",
        a = { '<cmd>lua require("actions-preview").code_actions()<cr>', "Code Action" },
        d = { "<cmd>Glance definitions<cr>", "Definition" },
        h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Definition" },
        r = { "<cmd>Glance references<cr>", "References" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable" },
        t = { "<cmd>Glance type_definitions<cr>", "Type Definition" },
    },
    s = {
        name = "Search",
    },
    t = {
        name = "Terminal",
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal" },
        v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical" },
    },
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
