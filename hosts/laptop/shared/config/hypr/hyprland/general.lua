hl.config({
    general = {
        gaps_in  = 1,
        gaps_out = 2,
        border_size = 2,
        col = {
            active_border   = "rgba(8a8a8aaa)",
            inactive_border = "rgba(474747aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
    },

    binds = {
        scroll_event_delay=600,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },
    
    debug = {
        disable_logs = false,
    }
})
