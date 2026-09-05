hl.window_rule({
    name  = "windowrule-1",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "windowrule-2",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "windowrule-3",
    match = { title = "(Open Directory)" },
    size  = "monitor_w*0.5 monitor_h*0.6",
    move  = "monitor_w*0.25 monitor_h*0.2",
})

hl.window_rule({
    name  = "windowrule-4",
    match = { title = "(Select one or more files to open)" },
    size  = "monitor_w*0.5 monitor_h*0.6",
    move  = "monitor_w*0.25 monitor_h*0.2",
})

hl.window_rule({
    name  = "windowrule-5",
    match = { title = "(Synthesizer V Studio Pro - .*)" },
    tile = true,
})

hl.window_rule({
    name  = "windowrule-6",
    match = { class = "net.lutris.Lutris", title = "Log for Arknights: Endfield (wine)" },
    float = true,
})

hl.window_rule({
    name  = "windowrule-7",
    match = { class = "steam_app_default", title = "GRYPHLINK" },
    float = true,
})

hl.window_rule({
    name  = "windowrule-8",
    match = { class = "steam_app_default", title = "Form" },
    float = true,
})

hl.window_rule({
    name  = "windowrule-9",
    match = { class = "(org.kde.kdeconnect.daemon)"},
    tile = false,
    float = true,
})

hl.window_rule({
    name = "windowrule-10",
    float = true,
    pin = true,
    no_shadow = true,
    size = "monitor_w*0.35 monitor_h*0.35",
    move  = "monitor_w*0.65 monitor_h*0.65",
    no_initial_focus = true,
    match = { title = "(Picture-in-Picture)" },
})

hl.window_rule({
    name = "windowrule-11",
    match = { title = "DOOMEternal" },
    fullscreen = true,
    tile = true,
})
