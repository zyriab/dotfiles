return {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        {
            "williamboman/mason.nvim",
            opts = {
                ui = {
                    border = "rounded",
                },
            },
            config = true,
        },
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        local autoformat = require("configs.lsp.autoformat")
        local register_keys = require("configs.lsp.register-keys")
        local servers = require("configs.lsp.servers")
        local ui_config = require("configs.lsp.ui-config")

        register_keys.setup()
        autoformat.setup()
        servers.setup()
        ui_config.setup()
    end,
}
