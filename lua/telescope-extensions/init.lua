-- Exit if can't load module
local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local M = {}

--[[
Opens a file picker with Neovim configuration files to make a quick edit,
useful to make quick changes to Neovim's configuration without having to CDW
]]
function M.neovim_config()
    -- local cwd_neovim_config = ''
    -- local USER = vim.fn.expand('$USER')
    -- if vim.fn.has('unix') == 1 then
    --     cwd_neovim_config = '/home/' .. USER .. '/.config/nvim'
    -- elseif vim.fn.has('mac') == 1 then
    --     cwd_neovim_config = '/Users/' .. USER .. '/.config/nvim'
    -- else
    --     print('Cannot detect your OS')
    --     cwd = '~/.config/nvim'
    -- end
    local opts = {
        prompt_title = '\\ NVim Config /',
        previewer = false,
        cwd = '~/.config/nvim',
        file_ignore_patterns = { "node_modules" },
        prompt_prefix = '  ',
        layout_config = {
            width = 0.5,
        },
    }
    require'telescope.builtin'.find_files(opts)
end

-- Returns true if current directory is a git worktree
function M.is_git_worktree()
    local _, ret, stderr = require'telescope.utils'.get_os_command_output(
    {
        'git', 'rev-parse', '--is-inside-work-tree'
    })
    -- print(vim.inspect(ret))
    if ret == 0 then return true else return false end
end

function M.git_files()
    local opts = {
        prompt_title = "\\ Git Files /",
        follow = 'true',
        -- hidden = 'false',
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.95,
        },
    }
    require'telescope.builtin'.git_files(opts)
end

--[[
This function evaluates if we are inside a directory managed by git,
if true, it runs function git_files(), otherwise it runs telescope's
builtin file_browser() function.
]]
function M.find_files()
    local _is_git_worktree = M.is_git_worktree()
    if _is_git_worktree then
        M.git_files()
    else
        local opts = {
            prompt_title = "\\ Find Files /",
            -- previewer = 'true',
            follow = 'true',
            -- hidden = 'false',
            layout_strategy = "horizontal",
            layout_config = {
              width = 0.95,
              preview_width = 0.65,
            },
            -- prompt_prefix = '  ',
            prompt_prefix = '  ',
            -- cwd = '%p',
            file_ignore_patterns = { "node_modules" },
        }
        require'telescope.builtin'.find_files(opts)
    end
end

function M.grep_within_grep()
    local opts = {
        prompt_title = "\\ Secondary Grep /",
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.9,
        },
        search = vim.fn.input('Rg> '),
    }
    require'telescope.builtin'.grep_string(opts)
end

function M.git_branches()
    local opts = {
        prompt_title = "\\ Git Branches /",
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.9,
        },
        prompt_prefix = '  ',
    }
    local _is_git_worktree = M.is_git_worktree()
    if _is_git_worktree then
        require'telescope.builtin'.git_branches(opts)
    else
        -- print('Not a git worktree directory')
        require('notify-extensions').notify("Warning", "Not a git working tree", 3, 2000)
        return
    end
end

function M.git_commits()
    local opts = {
        prompt_title = "\\ Git Commits /",
        layout_strategy = "horizontal",
        -- layout_strategy = "vertical",
        layout_config = {
            width = 0.9,
        },
        prompt_prefix = '  ',
    }
    local _is_git_worktree = M.is_git_worktree()
    if _is_git_worktree then
        require'telescope.builtin'.git_commits(opts)
    else
        -- print('Not a git worktree directory')
        require('notify-extensions').notify("Warning", "Not a git working tree", 3, 2000)
        return
    end
end

function M.notes()
    local opts = {
        prompt_title = "\\ Notes - IT /",
        layout_strategy = "horizontal",
        layout_config = {
            preview_width = 0.65,
        },
        cwd = '~/bitbucket.org/mine/it/',
        prompt_prefix = '   ',
    }
    require'telescope.builtin'.file_browser(opts)
end

-- Adding module to the _G global variable.
_G.utils = M
return M
