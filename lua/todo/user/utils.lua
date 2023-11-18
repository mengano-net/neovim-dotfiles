local M = {}
local cmd = vim.cmd

function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. table.concat(autocmd, ' '))
    end
    cmd('augroup END')
end

function P(v)
    print(vim.inspect(v))
    return v
end

function RELOAD(...)
    return require("plenary.reload").reload_module(...)
end

function R(name)
    RELOAD(name)
    return require(name)
end

function M.test()
    print('test')
end

-- We want to be able to access utils in all our configuration files
-- so we add the module to the _G global variable.
_G.utils = M
return M
