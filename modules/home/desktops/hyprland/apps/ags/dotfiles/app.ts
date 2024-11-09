// Astal
import { App } from "astal/gtk3"

// Utilities
import { monitorFile } from "astal/file"
import { exec } from "astal/process"

// Stylesheets
import style from "./scss/style.scss"

// Widgets
import Bar from "./widget/Bar"

// Start the application
App.start({
  css: style,
  instanceName: "bar",
  requestHandler(request, res) {
    print(request)
    res("ok")
  },
  main() {
    App.get_monitors().map(Bar)
  },
})

// Autoreload stylesheets
monitorFile(
  // Directory containting all stylesheets
  `./scss`,

  // Reload function
  () => {
    // Main stylesheet and target CSS file
    const scss = `./scss/style.scss`
    const css = `./css/style.css`

    // Compile, reset and apply styles
    exec(`sassc ${scss} ${css}`)
    App.reset_css()
    App.apply_css(css)
  },
)
