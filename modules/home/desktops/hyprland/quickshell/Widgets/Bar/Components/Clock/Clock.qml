import QtQuick
import "root:/"

Text {
	text: Time.time
	font.family: Globals.fontFamily
	font.pixelSize: Globals.fontSize
	color: Globals.textColor
}
