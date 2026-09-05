---------------------
----- VARIABLES -----
---------------------
local terminal = "uwsm app -- kitty"
local fileManager = "uwsm app -- nautilus"
local menu = 'rofi -show drun -run-command "uwsm app -- {cmd}"'
local emoji_picker = 'e=$(rofi -show emoji -emoji-format "{emoji}" -theme "$HOME"/.config/rofi/emoji.rasi) && [[ -n "$e" ]] && sleep 0.1 && wtype "$e"'
local browser = "uwsm app -- /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=librewolf --file-forwarding io.gitlab.librewolf-community"
local discord = "uwsm app -- vesktop --disable-gpu-compositing --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
local codium = "uwsm app -- codium --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland"

local clipboardmgr = "~/.config/scripts/clipboard.sh"
local npctl = "~/.config/scripts/npctl.sh"
local workspace_switch = "~/.config/scripts/workspace_switch.sh"
local screenrec = "~/.config/scripts/screenrec.sh"
local atomicwall = "~/.config/scripts/atomic_wall.sh"
local mainMod = "SUPER"



---------------------
------ FN KEYS ------
---------------------
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),{ repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 5%-"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +5%"), { repeating = true, locked = true })

hl.bind("XF86AudioStop", hl.dsp.exec_cmd(npctl .. " --stop"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(npctl .. " --prev"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(npctl .. " --toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(npctl .. " --next"), { locked = true })


---------------------
----- APP BINDS -----
---------------------
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(discord))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(codium))



----------------------
----- WORKSPACES -----
----------------------
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function() hl.exec_cmd(menu) end
})
hl.gesture({
    fingers = 3,
    direction = "down",
    action = function() hl.exec_cmd("pkill -15 rofi") end
})
hl.gesture({
    fingers = 3,
    direction = "vertical",
    mods = mainMod,
    action = "fullscreen",
})

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + T", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + ALT + T", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod ..  " + mouse:276", hl.dsp.exec_cmd(workspace_switch), { mouse = true })
hl.bind(mainMod ..  " + mouse:275", hl.dsp.focus({ workspace = "r-1" }), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.exec_cmd(workspace_switch),  { mouse = true })
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1" }),  { mouse = true })

hl.bind(mainMod ..  " + left", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod ..  " + right", hl.dsp.focus({direction = "right"}))
hl.bind(mainMod .. " + up", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + down", hl.dsp.focus({direction = "down"}))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({mode="maximized"}))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("pidof librewolf && pkill -15 librewolf"))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.float())
hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({next=false}))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(clipboardmgr))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(emoji_picker))
hl.bind(mainMod .. " + ALT + 4", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(atomicwall .. " nuke"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(atomicwall))

---------------------
------- MEDIA -------
---------------------

hl.bind("PRINT", hl.dsp.exec_cmd("pidof slurp || hyprshot --freeze -m active --mode output -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("pidof slurp || hyprshot --freeze -m region -o ~/Pictures/Screenshots"))

hl.bind("CTRL + SHIFT + ALT + R", hl.dsp.exec_cmd(screenrec))
hl.bind("SHIFT + F12", hl.dsp.exec_cmd(screenrec))
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("hyprpicker -a -r"))
