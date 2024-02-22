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

-- Yank into OS clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "[Y]ank selection into OS clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "[Y]ank selection into OS clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "[Y]ank line into OS clipboard" })
vim.keymap.set("n", "<leader>yy", "\"+yy", { desc = "[YY]ank line into OS clipboard" })

-- Paste over selection without losing buffer contents
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "[P]aste over selection w/o losing buffer" })

-- Delete without losing buffer content
vim.keymap.set("n", "<leader>d", "\"_d", { desc = "[D]elete w/o losing buffer" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "[D]elete w/o losing buffer" })

-- Terminal
vim.api.nvim_create_user_command("TermToggle", function()
    local is_open = vim.g.term_win_id ~= nil and vim.api.nvim_win_is_valid(vim.g.term_win_id)

    if is_open then
        vim.api.nvim_win_hide(vim.g.term_win_id)
        vim.g.term_win_id = nil
        return
    end

    -- Open new window 25 lines tall at the bottom of the screen
    vim.cmd("botright 25 new")
    vim.g.term_win_id = vim.api.nvim_get_current_win()

    local has_term_buf = vim.g.term_buf_id ~= nil and vim.api.nvim_buf_is_valid(vim.g.term_buf_id)

    if has_term_buf then
        vim.api.nvim_win_set_buf(vim.g.term_win_id, vim.g.term_buf_id)
    else
        vim.cmd.term()
        vim.g.term_buf_id = vim.api.nvim_get_current_buf()
    end

    vim.cmd.startinsert()
end, {})

-- For session manager usage
vim.api.nvim_create_user_command("TermClose", function()
    if vim.g.term_win_id ~= nil then
        vim.api.nvim_win_close(vim.g.term_win_id, true)
        vim.g.term_win_id = nil
    end
    if vim.g.term_buf_id ~= nil then
        vim.api.nvim_buf_delete(vim.g.term_buf_id, { force = true })
        vim.g.term_buf_id = nil
    end
end, {})

vim.keymap.set("n", "<C-t>", vim.cmd.TermToggle, { desc = "Toggle [^][T]erminal", silent = true })
vim.keymap.set("t", "<C-t>", vim.cmd.TermToggle, { desc = "Toggle [^][T]erminal", silent = true })

-- Automagically calls `/%s` with currently hovered word pre-entered
-- vim.keymap.set(
--     "n",
--     "<leader>s",
--     [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
--     { desc = "[S] Automagically prefill `/%s` w/ selection" }
-- )

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local group = vim.api.nvim_create_augroup("custom-yank-highlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})
