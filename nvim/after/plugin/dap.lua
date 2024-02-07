local dap = require("dap")
local utils = require("dap.utils")
local dapui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")
local dap_go = require("dap-go")
local widgets = require("dap.ui.widgets")
local dap_vscode_js = require("dap-vscode-js")
local npm_dap = require("npm-dap")
local sign = vim.fn.sign_define

-- Set up the sign for breakpoints
sign("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" })
sign("DapBreakpointCondition", { text = "󱉎", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "󰛓", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign("DapStopped", { text = "󰋇", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })
sign("DapBreakpointRejected", { text = "󱏶", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })

vim.keymap.set("n", "<F5>", function() dap.continue() end)
vim.keymap.set("n", "<leader><F5>", function() dap.terminate() end)
vim.keymap.set("n", "<F10>", function() dap.step_over() end)
vim.keymap.set("n", "<F11>", function() dap.step_into() end)
vim.keymap.set("n", "<F12>", function() dap.step_out() end)
vim.keymap.set("n", "<Leader>b", function() dap.toggle_breakpoint() end)
vim.keymap.set("n", "<Leader>B", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)

vim.keymap.set({ "n", "v" }, "<Leader>dk", function()
    widgets.hover()
end)

vim.keymap.set("n", "<leader>du", function()
    dapui.toggle()
end)

-- Events/listeners to trigger UI
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dapui.setup()
dap_virtual_text.setup()

-- Go
dap_go.setup()

-- JS/TS
-- See: https://github.com/mxsdev/nvim-dap-vscode-js
dap_vscode_js.setup({
    debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
    -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
    -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

-- See: https://www.lazyvim.org/extras/lang/typescript#nvim-dap
if not dap.adapters["pwa-node"] then
    dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
                vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
                "${port}",
            },
        }
    }
end

for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
    local node_client = "node"

    if language == "typescript" or language == "typescriptreact" then
        node_client = "ts-node"
    end

    dap.configurations[language] = {
        -- NODE
        {
            name = "Launch file",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            rootPath = "${workspaceFolder}",
            -- TODO: check if this is ok with JS
            sourceMaps = true,
            skilpFiles = { "<node_internals>/**" },
            protocol = "inspector",
            -- console = "integratedTerminal",
            runtimeExecutable = node_client,
        },
        {
            name = "Attach",
            type = "pwa-node",
            request = "attach",
            cwd = "${workspaceFolder}",
            rootPath = "${workspaceFolder}",
            sourceMaps = true,
            skilpFiles = { "<node_internals>/**" },
            protocol = "inspector",
            console = "integratedTerminal",
            processId = utils.pick_process,
            runtimeExecutable = node_client,
            outFiles = { "${workspaceFolder}/dist/**/*.js" },
        },
        -- ENDOF NODE
        -- JEST
        {
            name = "Debug Jest tests",
            type = "pwa-node",
            request = "launch",
            -- trace = true, -- include debugger info
            runtimeExecutable = node_client,
            runtimeArgs = {
                "./node_modules/jest/bin/jest.js",
                "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            outFiles = { "${workspaceFolder}/dist/**/*.js" },
            internalConsoleOptions = "neverOpen",
        }
        -- ENDOF JEST
    }
end

npm_dap.setup()
