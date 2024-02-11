return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        vim.keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Next []] [T]odo comment" })

        vim.keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Previous [[] [T]odo comment" })

        vim.keymap.set("n", "<leader>td", function()
            vim.cmd("TodoQuickFix")
        end, { desc = "Show [T]o[D]o comments in QuickFix" })

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
