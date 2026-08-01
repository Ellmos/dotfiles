------------------
---- MONITORS ----
------------------

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "1920x0",
	scale = "1",
})

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("alacritty -e ~/.config/hypr/scripts/update_brave.sh")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 3,

		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},

		resize_on_border = true,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Bezier curves
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Animations configurations
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "fr, us",
		-- kb_options = "grp:win_space_toggle",

		numlock_by_default = true,
		repeat_delay = 250,
		follow_mouse = 1,
		sensitivity = 0.1,

		touchpad = {
			natural_scroll = true,
			scroll_factor = 0.75,
		},
	},

	misc = {
		force_default_wallpaper = 0,
		focus_on_activate = true,
		-- new_window_takes_over_fullscreen = 2,
		initial_workspace_tracking = 2,
	},
})

-- Gestures configuration
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "fullscreen", mode = "maximize" })

---------------------
---- KEYBINDINGS ----
---------------------

local mod = "SUPER"

-- Main System Binds
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("alacritty"))
hl.bind(mod .. " + SHIFT + A", hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("bash ~/.config/rofi/powermenu.sh"))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun -theme ~/.config/rofi/themes/drun.rasi"))
hl.bind(mod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("rofi -show run -theme ~/.config/rofi/themes/run.rasi"))
hl.bind(mod .. " + W", hl.dsp.exec_cmd("rofi -show window -theme ~/.config/rofi/themes/window.rasi"))
hl.bind(
	mod .. " + B",
	hl.dsp.exec_cmd("/usr/bin/brave-browser-stable --enable-features=TouchpadOverscrollHistoryNavigation")
)
hl.bind(mod .. " + P", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mod .. " + CONTROL + F", hl.dsp.window.float({ action = "toggle" }))

-- Audio Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Media Keys
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

-- Brightness
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))

-- Utility Utilities (Screenshots / Calculator / Explorer)
hl.bind("Print", hl.dsp.exec_cmd("~/.local/bin/hyprshot -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.local/bin/hyprshot -m window"))
hl.bind("XF86Calculator", hl.dsp.exec_cmd("gnome-calculator"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd("nautilus --new-window"))

-- Focus Movement (Arrows & HJKL)
local directions =
	{ left = "left", right = "right", up = "up", down = "down", h = "left", l = "right", k = "up", j = "down" }
for key, dir in pairs(directions) do
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = dir }))
end

-- Move Windows (Arrows & HJKL)
for key, dir in pairs(directions) do
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir, follow = true }))
end

-- Workspace Switcher Map (AZERTY Layout friendly mapping)
local workspace_keys = {
	["ampersand"] = 1,
	["eacute"] = 2,
	["quotedbl"] = 3,
	["apostrophe"] = 4,
	["parenleft"] = 5,
	["minus"] = 6,
	["egrave"] = 7,
	["underscore"] = 8,
	["ccedilla"] = 9,
	["agrave"] = 10,
}

for key, ws_id in pairs(workspace_keys) do
	-- Switch to workspace
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = ws_id }))
	-- Move active window to workspace silently
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws_id, follow = false }), { silent = true })
end

-- Workspace Mouse Scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Window Actions (Drag and Resize)
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switches (Lid Close Actions)
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Fullscreen bordercolor window rule
hl.window_rule({
	name = "fullscreen-border-color",
	match = { fullscreen = true }, -- matches fullscreen:1 context
	border_color = { colors = { "rgba(9933ffee)", "rgba(33ccffee)" }, angle = 45 },
})

-- Calculator Rule
hl.window_rule({
	name = "calculator-floating",
	match = { class = "org.gnome.Calculator", title = "Calculator" },
	float = true,
})

-- Nautilus Rule
hl.window_rule({
	name = "nautilus-floating",
	match = { class = "org.gnome.Nautilus" },
	float = true,
	size = "70% 80%",
})

-- GTK Portal Rule
hl.window_rule({
	name = "gtk-portal-floating",
	match = { class = "xdg-desktop-portal-gtk" },
	float = true,
	size = "70% 80%",
})
