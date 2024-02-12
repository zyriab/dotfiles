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
        local dap_ui = require("configs.dap.nvim-dap-ui")

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

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
        vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Breakpoint" })

        dap_ui.setup(dap)

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|

        -- Install golang specific config
        require("dap-go").setup()
    end,
}
