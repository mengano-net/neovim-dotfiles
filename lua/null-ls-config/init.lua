local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    print("Couldn't require module 'null_ls'.")
    return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
local code_actions = null_ls.builtins.code_actions
local completion = null_ls.builtins.completion
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover

null_ls.setup({
    debug = false,
    sources = {
        code_actions.gitsigns,
        completion.spell,
        diagnostics.flake8.with({
            extra_args = { "--extend-ignore=E501" }
        }),
        formatting.prettier.with({
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
            extra_args = function(params)
                return params.options
                    and params.options.tabSize
                    and {
                        "--tab-width",
                        params.options.tabSize,
                    }
            end,
            filetypes = { "html", "json", "yaml", "markdown" },
        }),
        -- formatting.black.with({ extra_args = { "--fast" } }),
        formatting.stylua.with({
            extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/stylua.toml") },
        }),
        formatting.autopep8,
    },
})
