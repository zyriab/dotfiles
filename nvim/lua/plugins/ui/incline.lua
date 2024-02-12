-- TODO(incline):
-- Always show on `nofile` buffertype
-- if `nofile` buffertype, do not use bold and italic
-- if `nofile` buffertype, span the entire width
-- As of now, this is seriously buggy
--
-- "dapui_watches", "dapui_breakpoints",
-- "dapui_scopes", "dapui_console",
-- "dapui_stacks", "dap-repl"
return {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = function()
        local incline = require("incline")
        local render = require("configs.incline.render")
        local theme = require("github-theme.palette.github_dark_colorblind")
        local colors = theme.generate_spec(theme.palette)

        incline.setup({
            hide = {
                cursorline = true,
                focused_win = true,
                only_win = true,
            },
            ignore = {
                buftypes = {},
                filetypes = { "NvimTree" },
                floating_wins = true,
                unlisted_buffers = false,
                -- wintypes = {},
            },
            window = {
                zindex = 49,
                -- width = "fill",
                width = "fit",
                margin = {
                    vertical = 1,
                    horizontal = 1,
                },
                placement = {
                    vertical = "bottom",
                    horizontal = "right",
                },
                winhighlight = {
                    NormalNC = {
                        guibg = colors.bg3,
                    },
                },
            },
            highlight = {
                groups = {
                    InclineNormal = {
                        default = true,
                        group = "IncineNormalFloat",
                    },
                    InclineNormalNC = {
                        default = true,
                        group = "InclineNormalFloatNC",
                    },
                },
            },
            render = render.get,
        })
    end,
}
