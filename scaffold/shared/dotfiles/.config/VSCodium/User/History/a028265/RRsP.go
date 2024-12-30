package main

import (
    "github.com/mappu/miqt" // Import the miqt package
    "github.com/therecipe/qt/widgets" // Widgets for creating UI components
)

func main() {
    // Create the Qt application
    app := widgets.NewQApplication(len(os.Args), os.Args)

    // Create the main window
    window := widgets.NewQMainWindow(nil, 0)
    window.SetWindowTitle("Hello Golang with miqt")

    // Create a button and set its text
    button := widgets.NewQPushButton2("Click me!", nil)

    // Set up button click action
    button.ConnectClicked(func(checked bool) {
        button.SetText("Button Clicked!")
    })

    // Set the central widget of the window
    window.SetCentralWidget(button)

    // Set the window size and show it
    window.Resize2(300, 200)
    window.Show()

    // Execute the application
    app.Exec()
}
