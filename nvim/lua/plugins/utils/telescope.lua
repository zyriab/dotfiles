return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
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
        local extensions = require("configs.telescope.extensions")
        local live_grep_git_root = require("configs.telescope.live-grep-git-root")
        local keymaps = require("configs.telescope.keymaps")

        -- See `:help telescope` and `:help telescope.setup()`
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "node_modules" },
            },
        })

        extensions.setup()

        vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

        keymaps.setup()
    end,
}
