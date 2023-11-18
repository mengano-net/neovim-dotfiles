-- Clearing some builtin maps that I will steal for my own.
vim.keymap.set("", "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "S", "<Nop>", { noremap = true, silent = true })

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
        l = {
            "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({previewer=false,prompt_title='Open Buffers'}))<cr>",
            "List Opened Buffers",
        },
    },
    e = {
        name = "Edit",
        h = { "<cmd>nohl<cr>", "No Highlights" },
        c = { "<cmd>lua require('nvim-comment-frame').add_multiline_comment()<cr>", "Comment Block" },
        r = { "<cmd>retab<cr>", "Retab" },
    },
    f = {
        "<cmd>lua require('mengano.plugins.telescope.telescope-extensions').find_files()<cr>",
        "Find files",
    },
    F = {
        "<cmd>lua require('mengano.plugins.telescope.telescope-extensions').find_files_in_path()<cr>",
        "Find files in path...",
    },
    g = {
        name = "Goto",
        j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        J = {
            ":lua require('telescope.builtin').jumplist(require('telescope.themes').get_ivy())<cr>",
            "Jump Points",
        },
        k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
        z = {
            "<cmd> lua require('telescope').extensions.zoxide.list(require('telescope.themes').get_ivy{})<cr>",
            "Zoxide List"
        },
    },
    G = {
        name = "Git",
        b = { "<cmd>lua require('user.telescope-extensions').git_branches()<cr>", "Branches" },
        B = { "<cmd>lua require('gitsigns').blame_line{full=false}<cr>", "Blame" },
        c = { "<cmd>Git commit -s<cr>", "Commit" },
        f = { "<cmd>lua require('user.telescope-extensions').git_bcommits()<cr>", "Browse File Commits" },
        l = { "<cmd>lua require('user.telescope-extensions').git_commits()<cr>", "List commits" },
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
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
        -- d = { "<cmd>Glance definitions<cr>", "Definition" },
        D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
        f = {
            "<cmd>lua vim.lsp.buf.format{async=false,timeout_ms=2000} vim.diagnostic.enable()<cr>",
            "Format"
        },
        h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Definition" },
        m = { "<cmd>Mason<cr>", "List LSP servers installed." },
        r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
        -- r = { "<cmd>Glance references<cr>", "References" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable" },
        s = {
            "<cmd> lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy())<cr>",
            "Document Symbols"
        },
        -- t = { "<cmd>Glance type_definitions<cr>", "Type Definition" },
    },
    s = {
        name = "Search",
        g = {
            ":lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy())<cr>",
            "Live Grep",
        },
        t = {
            ":lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy())<cr>",
            "Help Tags",
        },
        c = {
            ":lua require('telescope.builtin').commands(require('telescope.themes').get_ivy())<cr>",
            "Commands",
        },
        G = {
            "<cmd>lua require('mengano.plugins.telescope.telescope-extensions').grep_within_grep()<cr>",
            "Grep within grep",
        },
        m = {
            ":lua require('telescope.builtin').man_pages(require('telescope.themes').get_ivy())<cr>",
            "Man Pages",
        },
        r = {
            ":lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy())<cr>",
            "Recent Files",
        },
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
