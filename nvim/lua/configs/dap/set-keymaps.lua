local dap = require("dap")
local persistent_breakpoints = require("persistent-breakpoints.api")

return function()
    -- HACK(DAP): Until I write my own Go config,
    -- easier to alternate between `dap.continue()` and `:GoDebug`
    vim.keymap.set("n", "<F5>", function()
        local filetype = vim.bo.filetype

        if filetype ~= "go" or dap.session() ~= nil then
            dap.continue()
            return
        end

        -- Launching a new session using `go.nvim` DAP config
        vim.cmd("GoDebug")
    end, { desc = "Debug: Start/Continue" })

    vim.keymap.set("n", "<leader><F5>", dap.terminate, { desc = "Debug: Teminate session" })
    vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })

    vim.keymap.set("n", "<leader>b", persistent_breakpoints.toggle_breakpoint, { desc = "Debug: Toggle [B]reakpoint" })
    vim.keymap.set(
        "n",
        "<leader>B",
        persistent_breakpoints.set_conditional_breakpoint,
        { desc = "Debug: Set conditional [B]reakpoint" }
    )
    vim.keymap.set(
        "n",
        "<leader>cb",
        persistent_breakpoints.clear_all_breakpoints,
        { desc = "Debug: [C]lear [B]reakpoints" }
    )

    -- NOTE: replaced by `persistent_breakpoints` plugin
    -- vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle [B]reakpoint" })
    -- vim.keymap.set("n", "<leader>B", function()
    --     dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    -- end, { desc = "Debug: Set conditional [B]reakpoint" })
    -- vim.keymap.set("n", "<leader>cb", dap.clear_breakpoints, { desc = "Debug: [C]lear [B]reakpoints" })
end
