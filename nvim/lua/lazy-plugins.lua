local lazy = require("lazy")
lazy.setup({
    -- Detect tabstop and shiftwidth automatically
    "tpope/vim-sleuth",

    -- Nicer vim.ui interfaces
    "stevearc/dressing.nvim",

    -- Highlight matching words under cursor
    "RRethy/vim-illuminate",

    -- Support for DBML files
    "zyriab/vim-dbml",

    { import = "plugins" },
}, {
    ui = {
        border = "rounded",
    },
})
