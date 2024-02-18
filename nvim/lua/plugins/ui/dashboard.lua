return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
        local dashboard = require("dashboard")
        local bible_verse = require("bible-verse")
        local bv_utils = require("bible-verse.utils")
        local telescope = require("telescope")
        local t_builtin = require("telescope.builtin")
        local session_lens = require("auto-session.session-lens")

        local function get_footer()
            local verses_result = bible_verse.query({ random = true })
            local verses_fmt_table = { "", "" }
            for _, verse in ipairs(verses_result) do
                local formatted_verse =
                    string.format("%s - %s %s:%s", verse.verse, verse.book, verse.chapter, verse.verse_number)
                table.insert(verses_fmt_table, formatted_verse)
            end

            table.insert(verses_fmt_table, "")

            -- Apply wrapping at half of editor's width
            local verses_fmt_wrap_table = bv_utils.wrap(verses_fmt_table, math.floor(vim.o.columns * 0.5))
            return verses_fmt_wrap_table
        end

        local function show_sessions()
            session_lens.search_session({
                path_display = { "shorten" },
                previewer = false,
                prompt_title = "󰚰 Restore Session",
                initial_mode = "normal",
            })
        end

        local function nav_to_config()
            local path = "~/.config/nvim"
            vim.cmd.cd(path)
            t_builtin.find_files({ cwd = path })
        end

        dashboard.setup({
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

                footer = get_footer,

                shortcut = {
                    {
                        desc = " Update ",
                        group = "DiagnosticWarn",
                        action = "Lazy update",
                        key = "u",
                    },
                    {
                        desc = "󰚰 Sessions ",
                        group = "DiagnosticInfo",
                        action = show_sessions,
                        key = "s",
                    },

                    {
                        desc = "󱜙 Projects ",
                        group = "DiagnosticError",
                        action = telescope.extensions.file_browser.file_browser,
                        key = "p",
                    },
                    {
                        desc = " Config ",
                        group = "DiagnosticHint",
                        action = nav_to_config,
                        key = "c",
                    },
                },
            },
        })
    end,
}
