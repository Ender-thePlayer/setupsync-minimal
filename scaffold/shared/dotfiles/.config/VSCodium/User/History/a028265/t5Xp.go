package main

import (
	"time"
	"os"

	"github.com/therecipe/qt/core"
	"github.com/therecipe/qt/gui"
	"github.com/therecipe/qt/quick"
)

func main() {
	os.Setenv("QT_QPA_PLATFORM", "wayland")
	os.Setenv("EGL_PLATFORM", "wayland")
	os.Setenv("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

	gui.NewQGuiApplication(len(os.Args), os.Args)
	core.QCoreApplication_SetOrganizationName("")
	core.QCoreApplication_SetApplicationName("asteroid-top")
	var view = quick.NewQQuickView(nil)

	var model = model.NewSystemInfoModel(nil)

	view.RootContext().SetContextProperty("SystemInfo", model)
	view.SetSource(core.NewQUrl3("qrc:///qml/main.qml", 0))
	view.ShowFullScreen()
	gui.QGuiApplication_Exec()
}