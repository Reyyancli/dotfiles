import { App } from "astal/gtk3"
import style from "./style.scss"
import DesktopWidgets from "./widget/DesktopWidgets"

App.start({
  css: style,
  main() {
    DesktopWidgets()
  },
})
