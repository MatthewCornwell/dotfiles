-- ~/.config/hypr/hyprland.lua

local terminal = "kitty"
local mainMod = "SUPER"

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("XCURSOR_SIZE", "24")

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
	col = {
	  active_border = "rgba(39ff14ee)",
	  inactive_border = "rgba(2d5a2daa)",
	},
    layout = "dwindle",
  },
  decoration = {
    rounding = 8,
    shadow = { enabled = true },
    blur = { enabled = true, size = 6, passes = 2 },
    active_opacity = 1.0,
    inactive_opacity = 0.85,
  },
  animations = { enabled = true },
  input = {
    kb_layout = "gb",
    follow_mouse = 1,
    touchpad = { natural_scroll = true },
  },
})

hl.on("hyprland.start", function()
  hl.dispatch(hl.dsp.exec_cmd("hash dbus-update-activation-environment 2>/dev/null && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY HYPRLAND_INSTANCE_SIGNATURE"))
  hl.dispatch(hl.dsp.exec_cmd("systemctl --user start graphical-session-pre.target"))
  hl.dispatch(hl.dsp.exec_cmd("systemctl --user start graphical-session.target"))
  hl.dispatch(hl.dsp.exec_cmd("waybar"))
  hl.dispatch(hl.dsp.exec_cmd("hypridle"))
  hl.dispatch(hl.dsp.exec_cmd("wl-paste --watch cliphist store"))
  hl.dispatch(hl.dsp.exec_cmd("swww-daemon"))
  hl.dispatch(hl.dsp.exec_cmd("sh -c 'sleep 2 && ~/.local/bin/wallpaper-rotate.sh > /tmp/wallpaper-rotate.log 2>&1'"))
  hl.dispatch(hl.dsp.exec_cmd("hyprpolkitagent"))

end)


hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", default = true })
-- BINDS START --

hl.bind(mainMod .. "+Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "+Q", hl.dsp.window.close())
hl.bind(mainMod .. "+R", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mainMod .. "+F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. "+V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. "+SHIFT+V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. "+SHIFT+E", hl.dsp.exit())
hl.bind(mainMod .. "+SHIFT+S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

for i = 1, 9 do
  hl.bind(mainMod .. "+" .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. "+SHIFT+" .. i, hl.dsp.window.move({ workspace = i }))
end

-- Move focus between windows -- confident, same shape as your working binds
hl.bind(mainMod .. "+left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "+up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+down", hl.dsp.focus({ direction = "down" }))

-- Swap a window's position in the layout -- confident, mirrors move({workspace=...}) already working
hl.bind(mainMod .. "+SHIFT+left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. "+SHIFT+right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. "+SHIFT+up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. "+SHIFT+down", hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. "+mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. "+mouse:273", hl.dsp.window.resize(), { mouse = true })

-- BINDS --

hl.monitor({ output = "eDP-1", mode = "2560x1600@165.00", position = "0x0", scale = 1.6 })
hl.monitor({ output = "DP-1", mode = "1920x1080@239.76", position = "1600x0", scale = 1 })
