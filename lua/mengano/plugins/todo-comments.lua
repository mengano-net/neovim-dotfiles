return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        vim.keymap.set("n", "<leader>gt", function()
            todo_comments.jump_next()
        end, { desc = "Todo comment next" })

        -- TODO: we need previous too, because navigation is conbersome without
        -- it
        -- vim.keymap.set("n", "<leader>gtp", function()
        --     todo_comments.jump_prev()
        -- end, { desc = "Todo comment previous" })

        todo_comments.setup()
    end
}
