return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    opts = {
        theme = "hyper",
        config = {
            packages = { enable = true },
            project = { icon = "󱜙" },
            mru = { icon = "" },
            header = {
                "",
                "",
                " /$$$$$$$              /$$               /$$$$$$$            /$$                                     ",
                "| $$__  $$            | $$              | $$__  $$          | $$                                     ",
                "| $$  \\ $$ /$$   /$$ /$$$$$$    /$$$$$$ | $$  \\ $$  /$$$$$$ | $$   /$$  /$$$$$$   /$$$$$$   /$$$$$$$",
                "| $$$$$$$ | $$  | $$|_  $$_/   /$$__  $$| $$$$$$$  |____  $$| $$  /$$/ /$$__  $$ /$$__  $$ /$$_____/",
                "| $$__  $$| $$  | $$  | $$    | $$$$$$$$| $$__  $$  /$$$$$$$| $$$$$$/ | $$$$$$$$| $$  \\__/|  $$$$$$ ",
                "| $$  \\ $$| $$  | $$  | $$ /$$| $$_____/| $$  \\ $$ /$$__  $$| $$_  $$ | $$_____/| $$       \\____  $$",
                "| $$$$$$$/|  $$$$$$$  |  $$$$/|  $$$$$$$| $$$$$$$/|  $$$$$$$| $$ \\  $$|  $$$$$$$| $$       /$$$$$$$/",
                "|_______/  \\____  $$   \\___/   \\_______/|_______/  \\_______/|__/  \\__/ \\_______/|__/      |_______/ ",
                "           /$$  | $$                                                                                ",
                "          |  $$$$$$/                                                                                ",
                "           \\______/                                                                                 ",
                "",
                "",
            },

            footer = function()
                local bible_verse = require("bible-verse")
                local utils = require("bible-verse.utils")
                local verses_result = bible_verse.query({ random = true })

                local verses_fmt_table = { "", "" }
                for _, verse in ipairs(verses_result) do
                    local formatted_verse =
                        string.format("%s - %s %s:%s", verse.verse, verse.book, verse.chapter, verse.verse_number)
                    table.insert(verses_fmt_table, formatted_verse)
                end

                table.insert(verses_fmt_table, "")

                -- Apply wrapping at half of editor's width
                local verses_fmt_wrap_table = utils.wrap(verses_fmt_table, math.floor(vim.o.columns * 0.5))
                return verses_fmt_wrap_table
            end,

            shortcut = {
                {
                    desc = " Update ",
                    group = "DiagnosticWarn",
                    action = "Lazy update",
                    key = "u",
                },
                {
                    desc = "󰚰 Restore session ",
                    group = "DiagnosticInfo",
                    action = "lua require('auto-session').AutoRestoreSession()",
                    key = "r",
                },
                {
                    desc = "󱜙 Projects ",
                    group = "DiagnosticError",
                    action = "FileBrowser",
                    key = "p",
                },
                {
                    desc = " config ",
                    group = "DiagnosticHint",
                    action = "cd ~/.config/nvim | NvimTreeOpen",
                    key = "c",
                },
            },
        },
    },
}
