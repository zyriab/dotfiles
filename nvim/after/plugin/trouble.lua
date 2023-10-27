local trouble = require("trouble")

vim.keymap.set("n", "<leader>xx", function()
    vim.cmd("TroubleToggle")
end,
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>xd", function()
    vim.cmd("TroubleToggle document_diagnostics")
end,
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>xc", function()
    vim.cmd("TroubleToggle workspace_diagnostics")
end,
    { silent = true, noremap = true }
)

vim.keymap.set("n", "<leader>xq", function()
    vim.cmd("TroubleToggle quickfix")
end,
    { silent = true, noremap = true }
)

trouble.setup()
