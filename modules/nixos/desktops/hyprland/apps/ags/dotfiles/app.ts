// Astal
import { App } from "astal/gtk4"

// Utilities
import { monitorFile, exec } from "astal"

// Stylesheets
import style from "./scss/style.scss"

// Widgets
import Bar from "./widgets/Bar"
import Dashboard from "./widgets/Dashboard"

// Auto reload stylesheets
monitorFile(
    // Directory containing all the stylesheets
    "./scss",

    // Callback - When the file/directory is modified
    () => {
        // Main stylesheet and target CSS file
        const scss = "./scss/style.scss";
        const css = "./css/style.css";

        // Compile, reset and apply styles
        exec(`sassc ${scss} ${css}`)
        App.reset_css();
        App.apply_css(css);
    }
)

// Application
App.start({
    css: style,
    instanceName: "bar",
    icons: `${SRC}/assets`,
    requestHandler(request, response) {
        print(request)
        response("Okay")
    },
    main() {
        App.get_monitors().map(Bar)
        App.get_monitors().map(Dashboard)
    },
})
