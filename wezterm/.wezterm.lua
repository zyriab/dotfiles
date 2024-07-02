-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

local function is_linux()
	return io.popen("uname -s"):read() == "Linux"
end

wezterm.on("update-right-status", function(window, _)
	window:set_right_status(window:active_workspace())
end)

-- This table will hold the configuration.
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.audible_bell = "Disabled"

-- Font
config.font = wezterm.font("FiraMono Nerd Font Mono")

if is_linux() then
	config.font_size = 10.3
	config.window_background_opacity = 0.85
else
	config.font_size = 11.0
	config.window_background_opacity = 0.65
	config.macos_window_background_blur = 30
end

-- Colors
config.color_scheme = "github_dark_colorblind"

-- Tab bar
config.use_fancy_tab_bar = false
config.mouse_wheel_scrolls_tabs = false
config.show_new_tab_button_in_tab_bar = false

-- Cursor
config.default_cursor_style = "SteadyBar"

local pane_size_step = 5

-- Keymaps
config.leader = { key = " ", mods = "ALT" }
config.keys = {
	{ key = "n", mods = "SHIFT|CTRL", action = act.ToggleFullScreen },

	-- Panes
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Pane resizing/zooming/moving
	{ key = "<", mods = "LEADER", action = act.AdjustPaneSize({ "Left", pane_size_step }) },
	{ key = ">", mods = "LEADER", action = act.AdjustPaneSize({ "Right", pane_size_step }) },
	{ key = "+", mods = "LEADER", action = act.AdjustPaneSize({ "Up", pane_size_step }) },
	{ key = "-", mods = "LEADER", action = act.AdjustPaneSize({ "Down", pane_size_step }) },
	{ key = "x", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	{ key = "m", mods = "LEADER", action = act.TogglePaneZoomState },

	-- Move between panes
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "b", mods = "SHIFT|CTRL", action = act.MoveTabRelative(-1) },
	{ key = "f", mods = "SHIFT|CTRL", action = act.MoveTabRelative(1) },

	-- Deactivating conflicting keymaps for Neovim
	{ key = "-", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "+", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "+", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
	{ key = "=", mods = "CTRL", action = act.DisableDefaultAssignment },
	{ key = "_", mods = "CTRL", action = act.DisableDefaultAssignment },

	-- WezMux
	{ key = "9", mods = "ALT", action = act({ ShowLauncherArgs = { flags = "FUZZY|WORKSPACES" } }) },
	{ key = "n", mods = "ALT", action = act.SwitchWorkspaceRelative(1) },
	{ key = "p", mods = "ALT", action = act.SwitchWorkspaceRelative(-1) },
}

return config
