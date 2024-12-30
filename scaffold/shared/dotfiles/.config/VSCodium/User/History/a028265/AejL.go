package main

import (
	"github.com/ncruces/zenity"
)

const defaultPath = ``

func main() {
	zenity.SelectFileMultiple(
		zenity.Filename(defaultPath),
		zenity.FileFilters{
			{"Go files", []string{"*.go"}, false},
			{"Web files", []string{"*.html", "*.js", "*.css"}, true},
			{"Image files", []string{"*.png", "*.gif", "*.ico", "*.jpg", "*.webp"}, true},
		})
}
