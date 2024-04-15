return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        -- TODO: find a way to instead do :TodoTelescope with get_ivy theme
        vim.keymap.set("n", "<leader>gt", function()
            -- todo_comments.jump_next()
            vim.cmd("TodoLocList")
        end, { desc = "Todo comments" })

        -- TODO: we need previous too, otherwise navigation seems cumbersom
        -- vim.keymap.set("n", "<leader>gtp", function()
        --     todo_comments.jump_prev()
        -- end, { desc = "Todo comment previous" })

        todo_comments.setup()
    end,
}
