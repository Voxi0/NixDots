import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import "root:/"

Item {
	width: parent.width
	height: Globals.barHeight
	Row {
		spacing: 4
		Repeater {
			model: Hyprland.workspaces
			Button {
				id: button
				onClicked: Hyprland.dispatch(`workspace ${modelData.id}`)
				background: Rectangle {
					color: modelData.focused ? Globals.textColor : button.hovered ? Globals.buttonHoverColor : Globals.barColor 
					radius: Globals.buttonRadius

					anchors.fill: parent
					anchors.topMargin: 2
					anchors.bottomMargin: 2

					border.color: Globals.textColor
					border.width: 1
				}
				contentItem: Text {
					text: modelData.name
					color: modelData.focused ? Globals.barColor : Globals.textColor
					font.family: Globals.fontFamily
					font.pixelSize: Globals.fontSize
				}
			}
		}
	}
}
