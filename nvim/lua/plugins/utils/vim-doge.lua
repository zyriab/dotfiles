return {
    "kkoomen/vim-doge",
    event = "BufRead",
    config = function()
        -- FIXME(vim-doge): this part does not work
        -- Disabling default mappings
        vim.g.doge_enable_mappings = 0
        vim.g.doge_mapping = "<leader>g"

        -- Displays annoying message when already installed
        -- vim.cmd("call doge#install()")
    end,
}
