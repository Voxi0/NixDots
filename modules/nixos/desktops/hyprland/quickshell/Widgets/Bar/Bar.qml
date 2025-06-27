import Quickshell
import Quickshell.Io
import QtQuick
import "root:/"
import "Components"

Item {
	id: root
	Variants {
		model: Quickshell.screens
		PanelWindow {
			property var modelData
			screen: modelData
			implicitHeight: 30
			color: Globals.barColor
			anchors {
				top: true
				left: true
				right: true
			}

			// Clock
			Clock { anchors.centerIn: parent }
		}
	}
}
