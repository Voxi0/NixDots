import { Variable, GLib, bind } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"
import Battery from "gi://AstalBattery"

function BatteryLevel() {
  const bat = Battery.get_default()
  return <box className = "Battery" visible = {bind(bat, "isPresent")}>
    <icon icon = {bind(bat, "batteryIconName")}/>
    <label label = {bind(bat, "percentage").as(p =>
      `${Math.floor(p * 100)} %`
    )}/>
  </box>
}

// Workspaces widget
function Workspaces() {
  const hypr = Hyprland.get_default()
  return <box className = "Workspaces">
    {bind(hypr, "workspaces").as(wss => wss
      .sort((a, b) => a.id - b.id)
      .map(ws => (
        <button
        className = {bind(hypr, "focusedWorkspace").as(fw =>
          ws === fw ? "focused" : "")}
        onClicked = {() => ws.focus()}>
        {ws.id}
        </button>
      ))
    )}
  </box>
}

// Clock
function Time({format}) {
  const time = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format(format)!)

  return <button
  onDestroy = {() => time.drop()}>
    <label
    className = "Time"
    label = {time()}
    />
  </button>
}

export default function Bar(monitor: Gdk.Monitor) {
  const anchor = Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT
  return <window
    className = "Bar"
    gdkmonitor = {monitor}
    exclusivity = {Astal.Exclusivity.EXCLUSIVE}
    anchor = {anchor}>
    <centerbox>
      <box hexpand halign = {Gtk.Align.START}>
        <Workspaces/>
      </box>

      <box>
        <Time format = "%I:%M %p"/>
      </box>

      <box hexpand halign = {Gtk.Align.END} >
      </box>
    </centerbox>
  </window>
}
