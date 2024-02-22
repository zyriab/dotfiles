return {
    "stevearc/qf_helper.nvim",
    config = function()
        local qf_helper = require("qf_helper")

        qf_helper.setup({
            prefer_loclist = false, -- Used for QNext/QPrev (see Commands below)
            sort_lsp_diagnostics = true, -- Sort LSP diagnostic results
            quickfix = {
                autoclose = true, -- Autoclose qf if it's the only open window
                default_bindings = false, -- Set up recommended bindings in qf window
                default_options = true, -- Set recommended buffer and window options
                max_height = 10, -- Max qf height when using open() or toggle()
                min_height = 1, -- Min qf height when using open() or toggle()
                track_location = true, -- Keep qf updated with your current location
            },
        })

        -- TODO: add loclist w/ `<leader>ll`

        vim.keymap.set("n", "<leader>qf", function()
            vim.cmd.QFToggle({ bang = true })
        end, { desc = "Toggle [Q]uick[F]ix", silent = true })
    end,
}
