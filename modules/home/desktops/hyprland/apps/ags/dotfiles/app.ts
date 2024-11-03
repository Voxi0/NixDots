import { App } from "astal/gtk3"
import style from "./style.scss"
import Bar from "./widget/Bar"

// Start the application
App.start({
  css: style,
  instanceName: "bar",
  requestHandler(request, res) {
    print(request)
    res("ok")
  },
  main: () => App.get_monitors().map(Bar),
})
