local keymap = vim.keymap.set
local keymap_opts = { noremap = true, silent = true }

--  if can't load module(s)
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then return end

local opts = {
    prefix = "<leader>",
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local setup = {
    plugins = {
        spelling = {
            enabled = true,
            suggestions = 20,
        },
    },
    presets = {
        operators = true, -- adds operators like d, y, registers them for motion, completions, etc
    },
    window = {
        border = "single",        -- none, single, double, shadow
        margin = { 0, 0, 0, 0 },  -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        align = "center",   -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
}

-- Clearing some builtin maps that I will steal for my own.
keymap("", "s", "<Nop>", keymap_opts)
keymap("", "S", "<Nop>", keymap_opts)

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
    f = { "<cmd>lua require('user.telescope-extensions').find_files()<cr>", "Find files" },
    F = { "<cmd>lua require('user.telescope-extensions').find_files_in_path()<cr>", "Find files in path..." },
    g = {
        name = "Goto",
        j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
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
    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    l = {
        name = "LSP",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        -- d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
        d = { "<cmd>Glance definitions<cr>", "Definition" },
        -- D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
        f = { "<cmd>lua vim.lsp.buf.format{async=false} vim.diagnostic.enable()<cr>", "Format" },
        h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Definition" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        m = { "<cmd>Mason<cr>", "List LSP servers installed." },
        -- r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
        r = { "<cmd>Glance references<cr>", "References" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable" },
        s = {
            "<cmd> lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy())<cr>",
            "Document Symbols"
        },
        t = { "<cmd>Glance type_definitions<cr>", "Type Definition" },
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
        j = {
            ":lua require('telescope.builtin').jumplist(require('telescope.themes').get_ivy())<cr>",
            "Jump Points",
        },
        G = {
            "<cmd>lua require('user.telescope-extensions').grep_within_grep()<cr>",
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

which_key.setup(setup)
which_key.register(mappings, opts)
