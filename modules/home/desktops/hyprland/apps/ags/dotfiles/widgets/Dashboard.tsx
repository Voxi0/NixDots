// Astal
import { App, Astal, Gdk } from "astal/gtk4"

// Dashboard
export default function Dashboard(monitor: Gdk.Monitor) {
    // Window anchors
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

    // Window
    return <window
    visible={false}
    name={"dashboard"}
    cssClasses={["Dashboard"]}
    application={App}
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={TOP | LEFT | RIGHT}>
    </window>
}
