package main

import (
	"github.com/mappu/miqt/qtcore"
	"github.com/mappu/miqt/qtgui"
	"github.com/mappu/miqt/qtwidgets"
	"os"
)

func main() {
	// Create the Qt application
	app := qtwidgets.NewQApplication(len(os.Args), os.Args)

	// Create the main window
	window := qtwidgets.NewQMainWindow(nil, 0)
	window.SetWindowTitle("Go Miqt Example")
	window.Resize2(400, 300)

	// Create a button widget
	button := qtwidgets.NewQPushButton2("Click Me", nil)
	button.ConnectClicked(func(_ bool) {
		button.SetText("Clicked!")
	})

	// Set the button as the central widget of the window
	window.SetCentralWidget(button)

	// Show the window
	window.Show()

	// Execute the application event loop
	qtcore.QCoreApplication_Exec()
}
