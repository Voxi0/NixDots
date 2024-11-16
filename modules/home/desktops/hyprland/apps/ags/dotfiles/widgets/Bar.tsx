import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, GLib, bind } from "astal"
import AstalHyprland from "gi://AstalHyprland?version=0.1"
import AstalBattery from "gi://AstalBattery?version=0.1"
import AstalNetwork from "gi://AstalNetwork?version=0.1"
import AstalTray from "gi://AstalTray?version=0.1"
import Gio from "gi://Gio?version=2.0"

// Menu
function MainMenu() {
	return <box className = "MainMenu">
		<button
		onClickRelease = {() => {
			try {
				Gio.Subprocess.new(
                    ['wofi', '--show', 'drun'],
                    Gio.SubprocessFlags.NONE
                )
            } catch(err) {logError(err)}
		}}>
			<icon icon = "./assets/nix-snowflake-colours.svg"/>
		</button>
	</box>
}

// Hyprland workspaces
function Workspaces() {
	const hypr = AstalHyprland.get_default()
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
function Time({format = "%I:%M %p"}) {
	const time = Variable<string>("").poll(1000, () => GLib.DateTime.new_now_local().format(format)!)
	return <button onDestroy = {() => time.drop()}>
		<label className = "Time" label = {time()}/>
	</button>
}

// WiFi
function WiFi() {
	const { wifi } = AstalNetwork.get_default()
    return <box className = "WiFi">
		<icon icon = {bind(wifi, "iconName")}/>
		<label label = {bind(wifi, "ssid").as(String)}/>
	</box>
}

// Battery
function BatteryLevel() {
	const bat = AstalBattery.get_default()
	return <box
	className = "Battery"
	visible = {bind(bat, "isPresent")}>
		<icon icon = {bind(bat, "batteryIconName")}/>
		<label label = {bind(bat, "percentage").as(p => `${Math.floor(p * 100)}%`)}/>
	</box>
}

// System tray
function SysTray() {
    const tray = AstalTray.get_default()
    return <box className = "SysTray">
        {bind(tray, "items").as(items => items.map(item => {
            if(item.iconThemePath) App.add_icons(item.iconThemePath)
            const menu = item.create_menu()

            return <button
            tooltipMarkup={bind(item, "tooltipMarkup")}
            onDestroy={() => menu?.destroy()}
            onClickRelease={self => {
                menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
            }}>
                <icon gIcon={bind(item, "gicon")} />
            </button>
        }))}
    </box>
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
    return <window
    className = "Bar"
    gdkmonitor = {gdkmonitor}
    exclusivity = {Astal.Exclusivity.EXCLUSIVE}
    anchor = {Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}
    application = {App}>
        <centerbox>
			<box hexpand halign = {Gtk.Align.START}>
				<MainMenu/>
				<Workspaces/>
			</box>
			<box hexpand halign = {Gtk.Align.CENTER}>
				<Time format = "%I:%M %p"/>
			</box>
			<box hexpand halign = {Gtk.Align.END}>
				<WiFi/>
				<BatteryLevel/>
				<SysTray/>
			</box>
		</centerbox>
	</window>
}
