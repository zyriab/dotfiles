vim.g.db_ui_use_nvim_notify = 1
vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_winwidth = 60


vim.keymap.set("n", "<leader>db", function()
    vim.cmd("DBUIToggle")
end)
