package main

import (
	"time"

	"github.com/ncruces/zenity"
)

func main() {
	zenity.Calendar("Select a date from below:",
		zenity.DefaultDate(2006, time.January, 1))
}
