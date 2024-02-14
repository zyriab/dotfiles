return {
    "lewis6991/satellite.nvim",
    config = function()
        local satellite = require("satellite")
        local filetypes = require("utils.filetypes")

        satellite.setup({
            current_only = false,
            winblend = 0,
            zindex = 40,
            excluded_filetypes = vim.tbl_extend("keep", { filetypes.nvimtree, filetypes.outline }, filetypes.dapui),
            width = 2,
            handlers = {
                cursor = {
                    overlap = false,
                    priority = 100,
                    enable = true,
                    -- Supports any number of symbols
                    symbols = { "󰹞" },
                    -- Highlights:
                    -- - SatelliteCursor (default links to NonText)
                },
                search = {
                    overlap = false,
                    priority = 100,
                    enable = true,
                    symbols = { "=" },
                },
                diagnostic = {
                    overlap = false,
                    priority = 100,
                    enable = true,
                    signs = { "≡" },
                    min_severity = vim.diagnostic.severity.HINT,
                },
                gitsigns = {
                    overlap = false,
                    priority = 100,
                    enable = true,
                    signs = {
                        add = "+",
                        change = "~",
                        delete = "_",
                    },
                },
                ---@diagnostic disable-next-line: missing-fields
                marks = { enable = false },
                quickfix = {
                    overlap = false,
                    priority = 100,
                    enable = true,
                    signs = { "" },
                    -- Highlights:
                    -- SatelliteQuickfix (default links to WarningMsg)
                },
            },
        })
    end,
}
