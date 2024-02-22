return {
    "terrortylor/nvim-comment",
    config = function()
        local nvim_comment = require("nvim_comment")

        -- Adding custom filetypes
        local group = vim.api.nvim_create_augroup("comment-toggle-group", { clear = true })

        -- SQL
        vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
            group = group,
            pattern = { "*.sql" },
            callback = function()
                vim.api.nvim_set_option_value("commentstring", "-- %s", { buf = 0 })
            end,
        })

        vim.keymap.set("n", "<C-/>", vim.cmd.CommentToggle, { silent = true })

        -- TODO: find a way to stay in visual mode
        -- The problem is that the range is not updated until we leave visual mode
        -- so if we select more or less text, the command only applies to the
        -- original selection...
        vim.keymap.set("v", "<C-/>", ":'<,'>CommentToggle<Cr>", { silent = true })

        nvim_comment.setup({
            comment_empty = false,
            create_mappings = false,
        })
    end,
}
