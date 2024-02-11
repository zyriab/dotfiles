-- [[ Basic Keymaps ]]

-- Heavenly switcharoo (happy hands)
vim.keymap.set("n", "0", "^", { noremap = true })
vim.keymap.set("n", "^", "0", { noremap = true })

-- Move on wordwrap like any other line
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Moving lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Cursor centering
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over selection without losing buffer contents
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "[P]aste over selection w/o losing buffer" })

-- Yank into OS clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "[Y]ank selection into OS clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "[Y]ank selection into OS clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "[Y]ank line into OS clipboard" })
vim.keymap.set("n", "<leader>yy", "\"+yy", { desc = "[YY]ank line into OS clipboard" })

-- Delete without losing buffer content
-- vim.keymap.set("n", "<leader>d", "\"_d", { desc = "[D]elete w/o losing buffer" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "[D]elete w/o losing buffer" })

-- Automagically calls `/%s` with currently hovered word pre-entered
-- vim.keymap.set(
--     "n",
--     "<leader>s",
--     [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
--     { desc = "[S] Automagically prefill `/%s` w/ selection" }
-- )

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})
