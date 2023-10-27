local nvim_comment = require("nvim_comment")

vim.keymap.set("n", "<C-/>", function()
    vim.cmd("CommentToggle")
end,
    { silent = true }
)

-- TODO find a way to stay in visual mode
-- The problem is that the range is not updated until we leave visual mode
-- so if we select more or less text, the command only applies to the
-- original selection...
vim.keymap.set("v", "<C-/>", ":'<,'>CommentToggle<Cr>",
{ silent = true }
)

nvim_comment.setup({
    comment_empty = false,
    create_mappings = false
})
