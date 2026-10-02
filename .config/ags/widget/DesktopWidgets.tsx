import { App, Astal, Gtk, astalify } from "astal/gtk3"
import { Variable, bind, GLib } from "astal"
import { readFile, writeFile } from "astal/file"
import { interval } from "astal/time"

const TextView = astalify<Gtk.TextView, Gtk.TextView.ConstructorProps>(Gtk.TextView)

/* ───────── Timer state ───────── */
const running = Variable(false)
const display = Variable("00:00")
const hasTime = Variable(false)
let startTime = 0 // ms timestamp when last started
let elapsed = 0   // ms accumulated while paused

const pad = (n: number) => String(n).padStart(2, "0")

function format(): string {
  const total = elapsed + (running.get() ? Date.now() - startTime : 0)
  const s = Math.floor(total / 1000)
  const secs = s % 60
  const mins = Math.floor(s / 60) % 60
  const hrs = Math.floor(s / 3600)
  return hrs > 0 ? `${pad(hrs)}:${pad(mins)}:${pad(secs)}` : `${pad(mins)}:${pad(secs)}`
}

const refresh = () => display.set(format())
interval(250, refresh)

function toggle() {
  if (running.get()) {
    elapsed += Date.now() - startTime
    running.set(false)
  } else {
    startTime = Date.now()
    running.set(true)
    hasTime.set(true)
  }
  refresh()
}

function reset() {
  running.set(false)
  hasTime.set(false)
  elapsed = 0
  startTime = 0
  refresh()
}

/* ───────── Notes persistence ───────── */
const NOTE_FILE = `${GLib.get_user_cache_dir()}/desktop_note.txt`

function loadNote(): string {
  try {
    return readFile(NOTE_FILE)
  } catch {
    return ""
  }
}

/* ───────── Cards ───────── */
function TimerCard() {
  return (
    <box
      vertical
      spacing={10}
      className={bind(running).as((r) =>
        `m3-card ${r ? "timer-running" : "timer-stopped"}`
      )}
    >
      <box spacing={8}>
        <label className="card-icon" label="⏱" />
        <label className="card-title" label="Timer" />
      </box>
      <label
        className="timer-display"
        halign={Gtk.Align.CENTER}
        label={bind(display)}
      />
      <box>
		  <button
			hexpand
			className="m3-btn"
			onClicked={toggle}
			label={bind(running).as((r) => (r ? "Pause" : "Start"))}
		  />
		  <revealer
			transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
			transitionDuration={300}
			revealChild={bind(hasTime)}
		  >
			<box css="padding-left: 10px;">
			  <button
				className="m3-btn-subtle"
				widthRequest={157}
				onClicked={reset}
				label="Reset"
			  />
			</box>
		  </revealer>
		</box>
    </box>
  )
}

function NotesCard() {
  return (
    <box vertical spacing={10} className="m3-card">
      <box spacing={8}>
        <label className="card-icon" label="󰏫" />
        <label className="card-title" label="Quick Notes" />
      </box>
      <scrollable className="note-scroll" heightRequest={160}>
        <TextView
          className="note-input"
          wrapMode={Gtk.WrapMode.WORD_CHAR}
          leftMargin={14}
          rightMargin={14}
          topMargin={14}
          bottomMargin={14}
          setup={(self) => {
            self.buffer.text = loadNote()
            self.buffer.connect("changed", () =>
              writeFile(NOTE_FILE, self.buffer.text)
            )
          }}
        />
      </scrollable>
    </box>
  )
}

/* ───────── Window ───────── */
export default function DesktopWidgets() {
  return (
    <window
      application={App}
      name="desktop_widgets"
      namespace="desktop_widgets"
      layer={Astal.Layer.BACKGROUND}
      anchor={Astal.WindowAnchor.BOTTOM | Astal.WindowAnchor.RIGHT}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      marginBottom={28}
      marginRight={28}
    >
      <box vertical spacing={14} widthRequest={360}>
        <TimerCard />
        <NotesCard />
      </box>
    </window>
  )
}
