local term_size = function(term)
    if term.direction == "horizontal" then
        -- return 20
        return vim.o.lines * 0.4
    elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
    end
end

return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup({
                close_on_exit = true,
                float_opts = { border = "curved" },
                hide_numbers = true, -- hide the number column in toggleterm buffers
                open_mapping = [[<c-\>]],
                -- shading_factor = 1,
                start_in_insert = true,
                persist_size = true,
                shell = "zsh",
                size = term_size,
                vim.keymap.set(
                    { "n" },
                    "<leader>tf",
                    "<cmd>ToggleTerm direction=float<cr>",
                    { desc = "( f )loat" }
                ),
                vim.keymap.set(
                    { "n" },
                    "<leader>th",
                    "<cmd>ToggleTerm direction=horizontal<cr>",
                    { desc = "( h )orizontal" }
                ),
                vim.keymap.set(
                    { "n" },
                    "<leader>tv",
                    "<cmd>ToggleTerm direction=vertical<cr>",
                    { desc = "( v )ertical" }
                ),
            })
        end,
    },
}
