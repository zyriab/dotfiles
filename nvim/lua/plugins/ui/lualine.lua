return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine = require("lualine")
        local custom_theme = require("lualine.themes.auto")

        -- For the theme customization, see:
        ---@url https://github.com/projekt0n/github-nvim-theme/blob/d92e1143e5aaa0d7df28a26dd8ee2102df2cadd8/lua/github-theme/util/lualine.lua#L13C3-L21C6
        local theme_spec = require("github-theme.spec").load("github_dark_colorblind")
        local theme_palette = theme_spec.palette
        local C = require("github-theme.lib.color")

        local function blend(color, a)
            return C(theme_spec.bg1):blend(C(color), a):to_css()
        end

        --- Create lualine group colors for github-theme
        ---@param color string
        local tint = function(color)
            return {
                a = { bg = color, fg = theme_spec.bg1 },
                b = { bg = blend(color, 0.2), fg = blend(color, 0.8) },
                c = { bg = blend(color, 0.01), fg = blend(color, 0.60) },
            }
        end

        custom_theme.insert = tint(theme_palette.yellow.base)
        custom_theme.visual = tint(theme_spec.sel0)

        -- vim.cmd("echo " .. theme_spec.sel1)

        lualine.setup({
            options = {
                theme = custom_theme,
                globalstatus = true,
                ignore_focus = { "NvimTree" },
            },
        })
    end,
}
