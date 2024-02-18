return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
    },
    config = function()
        local telescope = require("telescope")
        local load_extensions = require("configs.telescope.load-extensions")
        local live_grep_git_root = require("configs.telescope.live-grep-git-root")
        local set_keymaps = require("configs.telescope.set-keymaps")

        local PROJECTS_PATH = "~/Developer"

        -- See `:help telescope` and `:help telescope.setup()`
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "OUTLINE_*" },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
            extensions = {
                file_browser = {
                    theme = "ivy",
                    path = PROJECTS_PATH,
                    prompt_title = "Find Project",
                    results_title = "Projects 󱜙",
                    previewer = false,
                    initial_mode = "normal",
                    mappings = {
                        ["i"] = {
                            ["<C-o>"] = function(prompt_bufnr)
                                local entry = require("telescope.actions.state").get_selected_entry()
                                require("telescope.actions").close(prompt_bufnr)
                                vim.cmd.cd(entry.path)
                                vim.cmd.NvimTreeToggle()
                                vim.notify("Changed directory to " .. entry.path)
                            end,
                        },
                        ["n"] = {
                            ["o"] = function(prompt_bufnr)
                                local entry = require("telescope.actions.state").get_selected_entry()
                                require("telescope.actions").close(prompt_bufnr)
                                vim.cmd.cd(entry.path)
                                vim.cmd.NvimTreeToggle()
                                vim.notify("Changed directory to " .. entry.path)
                            end,
                        },
                    },
                },
            },
        })

        load_extensions()

        vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
        vim.api.nvim_create_user_command("FileBrowser", function()
            telescope.extensions.file_browser.file_browser({})
        end, {})

        set_keymaps()
    end,
}
