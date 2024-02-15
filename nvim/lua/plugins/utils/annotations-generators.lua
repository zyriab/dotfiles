return {
    {
        "danymat/neogen",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        version = "*", -- Uses only stable versions
        config = function()
            local neogen = require("neogen")

            neogen.setup({
                enabled = true,
                languages = {
                    lua = {
                        snippet_engine = "luasnip",
                    },
                },
            })

            vim.keymap.set(
                "n",
                "<leader>g",
                neogen.generate,
                { desc = "[G]enerate type annotations (JS/Lua)", silent = true }
            )

            vim.keymap.set({ "n", "i", "v" }, "<C-l>", neogen.jump_next)
            vim.keymap.set({ "n", "i", "v" }, "<C-h>", neogen.jump_prev)
        end,
    },
}
