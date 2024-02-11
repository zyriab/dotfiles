return {
    "terrortylor/nvim-comment",
    config = function()
        local nvim_comment = require("nvim_comment")

        -- Adding custom filetypes
        vim.api.nvim_create_augroup("CommentToggleGroup", { clear = true })

        -- SQL
        vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
            group = "CommentToggleGroup",
            pattern = { "*.sql" },
            callback = function()
                vim.api.nvim_buf_set_option(0, "commentstring", "-- %s")
            end,
        })

        local function comment_toggle()
            vim.cmd("CommentToggle")
        end

        vim.keymap.set("n", "<C-/>", comment_toggle, { silent = true })
        vim.keymap.set("n", "<C-_>", comment_toggle, { silent = true })

        -- TODO find a way to stay in visual mode
        -- The problem is that the range is not updated until we leave visual mode
        -- so if we select more or less text, the command only applies to the
        -- original selection...
        vim.keymap.set("v", "<C-/>", ":'<,'>CommentToggle<Cr>", { silent = true })
        vim.keymap.set("v", "<C-_>", ":'<,'>CommentToggle<Cr>", { silent = true })

        nvim_comment.setup({
            comment_empty = false,
            create_mappings = false,
        })
    end,
}
