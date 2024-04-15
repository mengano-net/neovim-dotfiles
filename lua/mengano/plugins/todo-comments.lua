return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        vim.keymap.set("n", "<leader>ft", function()
            -- todo_comments.jump_next()
            -- TODO: wrap in if statement to first check for telescope plugin
            vim.cmd("TodoTelescope")
        end, { desc = "Todo comments" })

        todo_comments.setup()
    end,
}
