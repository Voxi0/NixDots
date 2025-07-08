import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "root:/"
import "Components"
import "Components/Clock"

Item {
	id: root
	Variants {
		model: Quickshell.screens
		PanelWindow {
			property var modelData
			screen: modelData
			implicitHeight: Globals.barHeight
			color: Globals.barColor
			anchors {
				top: true
				left: true
				right: true
			}

			// Bar components
			Workspaces { }
			Clock { anchors.centerIn: parent; }
		}
	}
}
