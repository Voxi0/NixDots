pragma Singleton
import Quickshell
import QtQuick
import "root:/"

// Gets the latest system time/date
Singleton {
	id: root
	readonly property string time: Qt.formatDateTime(clock.date, Globals.clockFormat)
	SystemClock { id: clock }
}
