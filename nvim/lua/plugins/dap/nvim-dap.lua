return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "zyriab/npm-dap.nvim",

        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",

        "leoluz/nvim-dap-go",
        {
            "mxsdev/nvim-dap-vscode-js",
            opts = {
                debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
                adapters = { "pwa-node", "pwa-chrome" },
            },
        },
    },
    config = function()
        local dap = require("dap")
        local configure_ui = require("configs.dap.configure-ui")

        require("mason-nvim-dap").setup({
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,
            automatic_installation = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            ensure_installed = {
                "delve",
            },
        })

        configure_ui()

        -- Install golang specific config
        require("dap-go").setup()
    end,
}
