hl.config({
    gestures = {
        workspace_swipe_invert=1,
        workspace_swipe_min_speed_to_force=30,
        workspace_swipe_cancel_ratio=0.5,
        workspace_swipe_create_new=1,
    },

    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        mouse_refocus=false,

        touchpad = {
            natural_scroll = true,
            disable_while_typing = false,
            clickfinger_behavior = true,
        },
        
        sensitivity = 0,
    },
})

hl.device({
    name        = "tpps/2-ibm-trackpoint",
    sensitivity = -0.1,
})

hl.device({
    name        = "synaptics-tm3276-022",
    natural_scroll = true,
    enabled = true,
})