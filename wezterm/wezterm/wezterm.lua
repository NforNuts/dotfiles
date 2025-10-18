local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {
		position = { x = 0, y = 0 },
	})
end)

config.default_prog = { "/opt/homebrew/bin/zsh", "-l" }
config.automatically_reload_config = true

-- config.font = wezterm.font("Cascadia Code NF")
-- config.font = wezterm.font("0xProto Nerd Font Mono")
config.font = wezterm.font("UDEV Gothic 35NF")
config.color_scheme = "catppuccin-mocha"

config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.use_ime = true

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.window_padding = {
	top = 0,
	right = 0,
	bottom = 0,
	left = 0,
}
config.term = "wezterm"

config.colors = {
	cursor_bg = "white",
	cursor_fg = "black",

	tab_bar = {
		background = "#1C1C29",

		active_tab = {
			fg_color = "#000000",
			bg_color = "#EFB68E",
		},

		inactive_tab_hover = {
			fg_color = "#000000",
			bg_color = "#ABB3E7",
		},
	},
}

config.window_frame = {
	active_titlebar_bg = "none",
	inactive_titlebar_fg = "none",
}

config.font_size = 16
config.initial_rows = 69
config.initial_cols = 109

config.unix_domains = {
	{
		name = "unix",
	},
}
-- config.default_gui_startup_args = { "connect", "unix" }

config.window_close_confirmation = "NeverPrompt"
config.native_macos_fullscreen_mode = true
config.pane_focus_follows_mouse = true

config.command_palette_font_size = 16
config.max_fps = 120

config.disable_default_key_bindings = true
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 500 }
config.keys = {
	{
		key = "=",
		mods = "CMD",
		action = wezterm.action.IncreaseFontSize,
	},
	{
		key = "-",
		mods = "CMD",
		action = wezterm.action.DecreaseFontSize,
	},
	{
		key = "+",
		mods = "CMD",
		action = wezterm.action.ResetFontSize,
	},
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "q",
		action = wezterm.action.QuitApplication,
		mods = "CMD",
	},
	{
		key = "c",
		mods = "CMD",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action.ActivateCopyMode,
	},
	{
		key = "v",
		mods = "CMD",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	{
		key = "f",
		mods = "CMD|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "q",
		mods = "LEADER|CTRL",
		action = wezterm.action.SendKey({ key = "q", mods = "CTRL" }),
	},
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "-",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "|",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "RightArrow",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "UpArrow",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "DownArrow",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = ":",
		mods = "LEADER",
		action = wezterm.action.ActivateCommandPalette,
	},
}

config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

return config
