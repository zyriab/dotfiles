return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():append()
        end, { desc = "Harpoon: [A]ppend file" })
        vim.keymap.set("n", "<leader>m", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon: open quick [M]enu" })

        -- Uses Colemak-DHm home row
        vim.keymap.set("n", "<C-t>", function()
            harpoon:list():select(1)
        end, { desc = "Harpoon: [c-T] go to file 1" })
        vim.keymap.set("n", "<C-n>", function()
            harpoon:list():select(2)
        end, { desc = "Harpoon: [c-N] go to file 2" })
        vim.keymap.set("n", "<C-s>", function()
            harpoon:list():select(3)
        end, { desc = "Harpoon: [c-S] go to file 3" })
        vim.keymap.set("n", "<C-e>", function()
            harpoon:list():select(4)
        end, { desc = "Harpoon: [c-E] go to file 4" })
        vim.keymap.set("n", "<C-g>", function()
            harpoon:list():select(5)
        end, { desc = "Harpoon: [c-G] go to file 5" })
        vim.keymap.set("n", "<C-m>", function()
            harpoon:list():select(6)
        end, { desc = "Harpoon: [c-M] go to file 6" })
    end,
}
