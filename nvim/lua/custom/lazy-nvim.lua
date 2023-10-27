local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- DEV
    "folke/neodev.nvim",
    {
        "ZyriabDsgn/npm-dap.nvim",
        dir = "/mnt/DATA/dev/plugins/npm-dap.nvim"
    },
    -- UI
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme github_dark_colorblind")
            -- vim.cmd("colorscheme github_light_colorblind")
        end,
    },
    {
        "xiyaowong/transparent.nvim"
    },
    {
        "nvim-lualine/lualine.nvim"
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "stevearc/dressing.nvim"
    },
    -- EDITOR UPGRADES
    {
        "anthony-halim/bible-verse.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            diatheke = {
                translation = "KJV",
            },
        },
        config = true,
    },
    {
        "github/copilot.vim"
    },
    -- {
    --     "codota/tabnine-nvim",
    --     build = "./dl_binaries.sh"
    -- },
    {
        "mhartington/formatter.nvim"
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
    },
    {
        "terrortylor/nvim-comment"
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async"
    },
    {
        "norcalli/nvim-colorizer.lua"
    },
    {
        "windwp/nvim-autopairs"
    },
    {
        "windwp/nvim-ts-autotag"
    },
    -- DATABASE
    {
        "tpope/vim-dadbod"
    },
    {
        "pbogut/vim-dadbod-ssh",
        dependencies = { "tpope/vim-dadbod", lazy = true }
    },
    {
        "kristijanhusak/vim-dadbod-completion"
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = {
            { "tpope/vim-dadbod",                     lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "plsql" }, lazy = true },
        },
    },
    -- GIT
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "f-person/git-blame.nvim",
        event = "VeryLazy"
    },
    {
        "airblade/vim-gitgutter"
    },
    -- NAVIGATION
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
    },
    {
        "theprimeagen/harpoon"
    },
    {
        "nvim-tree/nvim-tree.lua"
    },
    {
        "mbbill/undotree"
    },
    -- DEBUGGER
    {
        "mfussenegger/nvim-dap"
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
    },
    {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = "mfussenegger/nvim-dap",
        opts = {
            debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
            adapters = { "pwa-node", "pwa-chrome" },
        }
    },
    {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
    -- LSP
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            {
                "williamboman/mason.nvim",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    table.insert(opts.ensure_installed, "js-debug-adapter")
                end,
            },                                       -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required
        }
    },
    -- TREESITTER
    -- TODO: move config to its dedicated file in nvim/after/treesitter.lua
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn"t work on Windows
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                init = function()
                    -- disable rtp plugin, as we only need its queries for mini.ai
                    -- In case other textobject modules are enabled, we will load them
                    -- once nvim-treesitter is loaded
                    require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
                    load_textobjects = true
                end,
            },
        },
        cmd = { "TSUpdateSync" },
        keys = {
            { "<c-space>", desc = "Increment selection" },
            { "<bs>",      desc = "Decrement selection", mode = "x" },
        },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        },
        config = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                ---@type table<string, boolean>
                local added = {}
                opts.ensure_installed = vim.tbl_filter(function(lang)
                    if added[lang] then
                        return false
                    end
                    added[lang] = true
                    return true
                end, opts.ensure_installed)
            end
            require("nvim-treesitter.configs").setup(opts)

            if load_textobjects then
                -- PERF: no need to load the plugin, if we only need its queries for mini.ai
                if opts.textobjects then
                    for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
                        if opts.textobjects[mod] and opts.textobjects[mod].enable then
                            local Loader = require("lazy.core.loader")
                            Loader.disabled_rtp_plugins["nvim-treesitter-textobjects"] = nil
                            local plugin = require("lazy.core.config").plugins["nvim-treesitter-textobjects"]
                            require("lazy.core.loader").source_runtime(plugin.dir, "plugin")
                            break
                        end
                    end
                end
            end
        end
    }
}


local opts = {}

require("lazy").setup(plugins, opts)
