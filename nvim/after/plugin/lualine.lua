local lualine = require("lualine")
local custom_theme = require("lualine.themes.base16")

custom_theme.normal.a.bg = "#58a6ff"
custom_theme.visual.a.bg = "#1e4273"
custom_theme.visual.a.fg = "#c9d1d9"
custom_theme.insert.a.bg = "#ec8e2c"

lualine.setup({
    options = {
        theme = custom_theme,
        ignore_focus = { "NvimTree" },
    }
})
