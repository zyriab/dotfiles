return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        ---@diagnostic disable-next-line: missing-parameter
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():append()
        end, { desc = "Harpoon [A]ppend file" })
        vim.keymap.set("n", "<C-c>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "[c-C] Harpoon view list" })

        -- Uses Colemak-DHm home row
        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(1)
        end, { desc = "[c-T] Harpoon go to file 1" })
        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():select(2)
        end, { desc = "[c-N] Harpoon go to file 2" })
        vim.keymap.set("n", "<C-s>", function()
            harpoon:list():select(3)
        end, { desc = "[c-S] Harpoon go to file 3" })
        vim.keymap.set("n", "<C-e>", function()
            harpoon:list():select(4)
        end, { desc = "[c-E] Harpoon go to file 4" })
        vim.keymap.set("n", "<C-g>", function()
            harpoon:list():select(5)
        end, { desc = "[c-G] Harpoon go to file 5" })
        vim.keymap.set("n", "<C-m>", function()
            harpoon:list():select(6)
        end, { desc = "[c-M] Harpoon go to file 6" })
    end,
}
