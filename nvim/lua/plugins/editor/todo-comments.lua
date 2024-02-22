return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        vim.keymap.set("n", "]t", todo_comments.jump_next, { desc = "Next []] [T]odo comment" })
        vim.keymap.set("n", "[t", todo_comments.jump_prev, { desc = "Previous [[] [T]odo comment" })

        vim.keymap.set("n", "<leader>td", function()
            vim.cmd.TodoQuickFix()
        end, { desc = "Show [T]o[D]o comments in quickfix" })

        -- FIXME: need to debug the RegEx
        todo_comments.setup({
            highlight = {
                pattern = [[.*<(KEYWORDS)\s*(:|\()]],
            },
            search = {
                pattern = [[\b(KEYWORDS)\s*(:|\()]],
            },
        })
    end,
}
