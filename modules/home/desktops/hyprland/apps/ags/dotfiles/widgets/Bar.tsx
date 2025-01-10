// TODO - System tray buttons are useless right now

// Astal
import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import { Variable, GLib, bind } from "astal"

// Astgl libraries
import AstalHyprland from "gi://AstalHyprland?version=0.1"
import AstalBattery from "gi://AstalBattery?version=0.1"
import AstalNetwork from "gi://AstalNetwork?version=0.1"
import AstalTray from "gi://AstalTray?version=0.1"

// Dashboard button - Toggles the dashboard
function DashboardButton() {
    return <box cssClasses={["DashboardButton"]}>
        <button onClicked={() => App.toggle_window("dashboard")}>
            <image iconName={"nix-snowflake-colours"}/>
        </button>
    </box>
}

// Hyprland workspaces
function Workspaces() {
    const hypr = AstalHyprland.get_default()
    return <box cssClasses={["Workspaces"]}>
        {bind(hypr, "workspaces").as(ws => ws
            .filter(ws => !(ws.id >= -99 && ws.id <= -2)) // Filter out special workspaces
            .sort((a, b) => a.id - b.id)
            .map(ws => (
                <button
                cssClasses={bind(hypr, "focusedWorkspace").as(fw => ws === fw ? ["focused"] : [""])}
				onClicked={() => ws.focus()}>
				    {ws.id}
                </button>
            ))
        )}
    </box>
}

// Clock
function Time({format="%I:%M %p"}) {
	const time = Variable<string>("").poll(1000, () => GLib.DateTime.new_now_local().format(format)!)
	return <button onDestroy = {() => time.drop()}>
		<label cssClasses={["Time"]} label = {time()}/>
	</button>
}

// Network
function WiFi() {
    const { wifi } = AstalNetwork.get_default()
    return <box cssClasses={["WiFi"]}>
        <image iconName={bind(wifi, "iconName")}/>
        <label label={bind(wifi, "ssid").as(String)}/>
    </box>
}

// Battery
function Battery() {
    const bat = AstalBattery.get_default()
    return <box
    visible={bind(bat, "isPresent")}
    cssClasses={["Battery"]}>
        <image iconName={bind(bat, "batteryIconName")}/>
        <label label = {bind(bat, "percentage").as(p => `${Math.floor(p * 100)}%`)}/>
    </box>
}

// System tray
function SysTray() {
    const tray = AstalTray.get_default()
    return <box cssClasses={["SysTray"]}>
        {bind(tray, "items").as(items => items.map(item => {
            // Add application icon
            if(item.iconThemePath) App.add_icons(item.iconThemePath)

            // System tray icon button
            return <button
            tooltipMarkup={bind(item, "tooltipMarkup")}>
                <image gicon={bind(item, "gicon")}/>
            </button>
        }))}
    </box>
}

// Bar
export default function Bar(monitor: Gdk.Monitor) {
    // Window anchors and GTK widget alignment
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
    const { START, CENTER, END } = Gtk.Align;

    // Window
    return <window
    visible
    name={"bar"}
    cssClasses={["Bar"]}
    application={App}
    gdkmonitor={monitor}
    anchor={TOP | LEFT | RIGHT}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}>
        <centerbox>
            <box hexpand halign={START}>
                <DashboardButton/>
                <Workspaces/>
            </box>
            <box hexpand halign={CENTER}>
                <Time format="%I:%M %p"/>
            </box>
            <box hexpand halign={END}>
                <WiFi/>
                <Battery/>
                <SysTray/>
            </box>
        </centerbox>
    </window>
}
