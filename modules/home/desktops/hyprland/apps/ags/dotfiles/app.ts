// Astal
import { App } from "astal/gtk3"

// Utilities
import { monitorFile } from "../../.local/share/ags"
import { exec } from "../../.local/share/ags"

// Stylesheets
import style from "./scss/style.scss"

// Widgets
import Bar from "./widgets/Bar"

// Start the application
App.start({
    css: style,
	instanceName: "bar",
	requestHandler(request, res) {
		print(request)
		res("Okay")
	},
    main() {
        App.get_monitors().map(Bar)
    },
})

// Autoreload stylesheets
monitorFile(
	// Directory containing all the stylesheets
	'./scss',

	// Callback - When the file/directory is modified
	() => {
		// Main stylesheet and target CSS file
		const scss = './scss/style.scss'
		const css = './css/style.css'

		// Compile, reset and apply styles
		exec(`sassc ${scss} ${css}`)
		App.reset_css()
		App.apply_css(css)
	},
)
