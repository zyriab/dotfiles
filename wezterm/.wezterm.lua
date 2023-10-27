-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local function is_linux()
    return io.popen("uname -s"):read() == "Linux"
end

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.audible_bell = "Disabled"

-- Font
config.font = wezterm.font "FiraMono Nerd Font Mono"
if is_linux() then
    config.font_size = 10.3
else
    config.font_size = 11.0
end

-- Colors
config.window_background_opacity = 0.85
config.color_scheme = "github_dark_colorblind"

-- Tab bar
config.use_fancy_tab_bar = false
config.mouse_wheel_scrolls_tabs = false
config.show_new_tab_button_in_tab_bar = false

-- Keymaps
config.leader = { key = " ", mods = "SHIFT" }
config.keys = {
    { key = "q", mods = "LEADER",     action = act.CloseCurrentPane({ confirm = true }), },
    { key = "n", mods = "SHIFT|CTRL", action = act.ToggleFullScreen, },
    { key = "v", mods = "LEADER",     action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "s", mods = "LEADER",     action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- move between panes
    { key = "h", mods = "LEADER",     action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER",     action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER",     action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER",     action = act.ActivatePaneDirection("Right") },
    { key = "b", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
    { key = "f", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },
}

return config
