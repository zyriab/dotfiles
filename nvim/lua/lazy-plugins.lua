local lazy = require("lazy")
lazy.setup({
    -- Git related plugins
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",

    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- Nicer vim.ui interfaces
    "stevearc/dressing.nvim",

    -- Support for DBML files
    "zyriab/vim-dbml",

    { import = "plugins" },
}, {
    ui = {
        border = "rounded",
    },
})
