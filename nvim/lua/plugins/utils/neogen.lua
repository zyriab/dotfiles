return {
    {
        "danymat/neogen",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        version = "*", -- Uses only stable versions
        config = function()
            local neogen = require("neogen")

            neogen.setup({
                enabled = true,
                snippet_engine = "luasnip",
            })

            vim.keymap.set("n", "<leader>doc", neogen.generate, { desc = "Generate type [DOC]umentation" })

            vim.keymap.set({ "n", "i", "v" }, "<C-l>", neogen.jump_next, { desc = "Type doc: Jump to next annotation" })
            vim.keymap.set(
                { "n", "i", "v" },
                "<C-h>",
                neogen.jump_prev,
                { desc = "Type doc: Jump to previous annotation" }
            )
        end,
    },
}
