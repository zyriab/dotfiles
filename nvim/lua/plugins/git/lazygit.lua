return {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "Open Lazy[GG]it" })
    end,
}
