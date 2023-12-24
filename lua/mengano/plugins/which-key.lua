-- Clearing some builtin maps that I will steal for my own.
vim.keymap.set("", "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "S", "<Nop>", { noremap = true, silent = true })

----------------------------------------------------------------------
--                 Extensions for Telescope plugin                  --
----------------------------------------------------------------------

local telescope_builtin = require("telescope.builtin")
local telescope_utils = require("telescope.utils")

-- Return true if local directory is a clone of a git repository
local is_git_worktree = function()
    local _, ret, stderr = telescope_utils.get_os_command_output({
        "git",
        "rev-parse",
        "--is-inside-work-tree",
    })
    -- print(vim.inspect(ret))
    if ret == 0 then
        return true
    else
        return false
    end
end

-- Telescope, listing files currently managed by git
local git_files = function()
    --[[ local opts = {
    prompt_title = "\\ Git Files /",
    follow = 'true',
    -- hidden = 'false',
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
    },
  }
  require'telescope.builtin'.git_files(opts) ]]
    telescope_builtin.git_files(require("telescope.themes").get_ivy({
        prompt_title = "Git Files",
        follow = "true",
        prompt_prefix = "  ",
    }))
end

-- Telescope's built-in fuzzy finder, using get_ivy theme
local find_files = function()
    if is_git_worktree() then
        git_files()
    else
        telescope_builtin.find_files(require("telescope.themes").get_ivy({}))
    end
end

-- Telescope built-in wrapper listing grep inside grep
local grep_within_grep = function()
    telescope_builtin.grep_string(require("telescope.themes").get_ivy({
        prompt_title = "Secondary Grep",
        search = vim.fn.input("Rg> "),
    }))
end

-- Telescope built-in wrapper, listing git branches
local git_branches = function()
    --[[ local opts = {
    prompt_title = "\\ Git Branches /",
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.9,
    },
    prompt_prefix = '  ',
  } ]]
    if is_git_worktree() then
        -- require'telescope.builtin'.git_branches(opts)
        telescope_builtin.git_branches(require("telescope.themes").get_ivy({
            prompt_title = "Git Branches",
            prompt_prefix = "  ",
        }))
    else
        vim.notify_once("Not a git working tree", 3, {})
        -- require("notify-extensions").notify("Warning", "Not a git working tree", "warn", 5000)
        return
    end
end

-- Telescope built-in wrapper - listing git commits
local git_commits = function()
    if is_git_worktree() then
        require("telescope.builtin").git_commits(require("telescope.themes").get_ivy({
            prompt_title = "Git Commits",
            prompt_prefix = "  ",
        }))
    else
        require("notify-extensions").notify("Warning", "Not a git working tree", "warn", 5000)
        return
    end
end

local git_bcommits = function()
    telescope_builtin.git_bcommits(require("telescope.themes").get_ivy({
        prompt_title = "Browser File Commits",
        prompt_prefix = "  ",
    }))
end

local find_files_in_path = function()
    local _path = vim.fn.input("Enter Directory: ", "", "dir")
    if _path == nil or _path == "" then _path = vim.fn.expand("%:p:h") end
    telescope_builtin.find_files(require("telescope.themes").get_ivy({
        prompt_title = "Find in directory: " .. _path,
        search_dirs = { _path },
    }))
end

local list_buffers = function()
    require("telescope.builtin").buffers(require("telescope.themes").get_ivy({
        previewer = false,
        prompt_title = "Open Buffers",
    }))
end

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
    b = { list_buffers, "Buffers" },
    e = {
        name = "Edit",
        h = { "<cmd>nohl<cr>", "No Highlights" },
        c = {
            "<cmd>lua require('nvim-comment-frame').add_multiline_comment()<cr>",
            "Comment Block",
        },
        r = { "<cmd>retab<cr>", "Retab" },
    },
    f = { find_files, "Find files" },
    F = { find_files_in_path, "Find files in path..." },
    g = {
        name = "Goto",
        j = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
        J = {
            ":lua require('telescope.builtin').jumplist(require('telescope.themes').get_ivy())<cr>",
            "Jump Points",
        },
        k = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
        r = {
            ":lua require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy())<cr>",
            "Recent Files",
        },
        z = {
            "<cmd> lua require('telescope').extensions.zoxide.list(require('telescope.themes').get_ivy{})<cr>",
            "Zoxide List",
        },
    },
    G = {
        name = "Git",
        b = { git_branches, "Branches" },
        B = { "<cmd>lua require('gitsigns').blame_line{full=false}<cr>", "Blame" },
        c = { "<cmd>Git commit -s<cr>", "Commit" },
        f = { git_bcommits, "Browse File Commits" },
        l = { git_commits, "List commits" },
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
        name = "LSP",p
        a = { '<cmd>lua require("actions-preview").code_actions()<cr>', "Code Action" },
        d = { "<cmd>Glance definitions<cr>", "Definition" },
        h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Definition" },
        r = { "<cmd>Glance references<cr>", "References" },
        R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename variable" },
        s = {
            "<cmd> lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy())<cr>",
            "Document Symbols",
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
        G = { grep_within_grep, "Grep within grep" },
        -- m = {
        --     ":lua require('telescope.builtin').man_pages(require('telescope.themes').get_ivy())<cr>",
        --     "Man Pages",
        -- },
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
