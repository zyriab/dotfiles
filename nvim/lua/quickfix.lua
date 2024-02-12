local function toggle()
    if #vim.fn.filter(vim.fn.getwininfo(), "v:val.quickfix == 1") == 0 then
        vim.cmd("copen")
    else
        vim.cmd("cclose")
    end
end

-- Toggles QuickFix
vim.keymap.set("n", "<leader>qf", toggle, { silent = true, desc = "Toggle [Q]uick[F]ix" })

-- QuickFix navigation
vim.keymap.set("n", "]q", function()
    vim.cmd("cn")
end, { silent = true, desc = "[]] [Q]uickFix next" })
vim.keymap.set("n", "[q", function()
    vim.cmd("cp")
end, { silent = true, desc = "[[] [Q]uickFix previous" })
vim.keymap.set("n", "]Q", function()
    vim.cmd("cfirst")
end, { silent = true, desc = "[]] [Q]uickFix first" })
vim.keymap.set("n", "[Q", function()
    vim.cmd("clast")
end, { silent = true, desc = "[[] [Q]uickFix last" })