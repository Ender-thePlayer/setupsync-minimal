package main

import (
    "image/color"
    "log"

    "gioui.org/app"
    "gioui.org/font/gofont"
    "gioui.org/io/system"
    "gioui.org/layout"
    "gioui.org/op"
    "gioui.org/text"
    "gioui.org/unit"
    "gioui.org/widget"
    "gioui.org/widget/material"
)

func main() {
    go func() {
        // Create a new window.
        w := app.NewWindow()

        // Material theme using Go fonts.
        th := material.NewTheme(gofont.Collection())

        // A button widget.
        var button widget.Clickable

        // Infinite loop to handle UI events.
        for e := range w.Events() {
            switch e := e.(type) {
            case system.FrameEvent:
                // Ops to record drawing operations.
                var ops op.Ops

                // Start layout.
                gtx := layout.NewContext(&ops, e)

                // Create a layout that centers content.
                layout.Center.Layout(gtx, func(gtx layout.Context) layout.Dimensions {
                    return material.Button(th, &button, "Click Me!").Layout(gtx)
                })

                // Render the frame.
                e.Frame(gtx.Ops)

            case system.DestroyEvent:
                return
            }
        }
    }()
    // Call app.Main to start the Gio application.
    app.Main()
}
