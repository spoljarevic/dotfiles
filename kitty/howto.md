# Kitty as a tmux Replacement — Cheat Sheet

Quick reference for the multiplexing keybinds added in `kitty.conf`. Keep this open until it's muscle memory.

> [!info] Scope
> This covers **panes, tabs, and layouts** inside a single kitty session. It does **not** cover detach/reattach — closing kitty (or losing the SSH connection) still kills the shells inside, unlike tmux's server model. See the note at the bottom.

---

## Panes (splits)

| Keybind | Action | tmux equivalent |
|---|---|---|
| `Ctrl+Shift+Enter` | New pane in the current layout | `prefix c` (new window, not pane) |
| `Ctrl+Shift+-` (minus) | Split **horizontally** (new pane below) | `prefix "` |
| `Ctrl+Shift+\` (backslash) | Split **vertically** (new pane beside) | `prefix %` |
| `Alt+←` `Alt+→` `Alt+↑` `Alt+↓` | Move focus to the neighboring pane | `prefix + arrow` |
| `Ctrl+Shift+R` | Enter **resize mode** — use arrows to resize, `Enter`/`Esc` to confirm | `prefix + arrow` (in resize mode) |
| `Ctrl+Shift+Z` | **Zoom** the focused pane fullscreen, press again to restore | `prefix z` |
| `Ctrl+Shift+E` | **Broadcast** keystrokes to every pane in the tab, until toggled off | `setw synchronize-panes` |

> [!tip] Directional splits
> `Ctrl+Shift+-` and `Ctrl+Shift+\` always split relative to the **focused pane**, so you can keep splitting to build up a grid — same mental model as tmux's `%`/`"`.

---

## Tabs

These are kitty defaults — already active, nothing new to configure.

| Keybind | Action | tmux equivalent |
|---|---|---|
| `Ctrl+Shift+T` | New tab | `prefix c` (tmux calls this a window) |
| `Ctrl+Shift+Q` | Close tab | `prefix &` |
| `Ctrl+Shift+→` / `Ctrl+Shift+←` | Next / previous tab | `prefix n` / `prefix p` |
| `Ctrl+Shift+[number]` | Jump to tab by number | `prefix [number]` |
| `Ctrl+Shift+Home` / `Ctrl+Shift+End` | First / last tab | — |

---

## Session layout on startup

`startup_session session.conf` recreates two tabs every time kitty launches — think of it as a default tmux session, minus the ability to resume a previous one.

**Tab 1 — `productivity`** (frontmost on launch):

```
+------------------------+
|         nvim           |  ~65%
+------------+-----------+
|   shell    |  claude   |  ~35%
+------------+-----------+
```

nvim starts focused; `Alt+arrow` to jump to the shell or claude pane. `Ctrl+Shift+→` moves to:

**Tab 2 — `terminal`**: a single plain shell, nothing special — split it further with `Ctrl+Shift+-` / `Ctrl+Shift+\` same as any other tab.

- Edit `session.conf` to change what opens by default (paths, commands, tabs, split direction).
- Delete the file and remove the `startup_session` line in `kitty.conf` to boot into a single plain window instead.

> [!tip] Reopening the productivity tab later
> If you close the `productivity` tab and want it back without restarting kitty, `session-productivity.conf` has the same layout as a standalone file:
> ```sh
> kitty --detach --session /home/ls/git/ls/Dotfiles/kitty/session-productivity.conf
> ```
> This opens it as a new OS window rather than a tab in the current one — kitty session files can only be loaded at process startup, not injected into a running instance as a new tab.

---

## Scripting (remote control)

`allow_remote_control yes` + `listen_on unix:@mykitty` let you drive kitty from the outside, e.g.:

```sh
kitty @ ls                     # inspect current windows/tabs/layout as JSON
kitty @ launch --location=vsplit  # open a new split from a script
kitty @ goto-layout stack          # switch layout programmatically
```

---

> [!warning] What kitty still can't do
> There is no detach/reattach. Kitty is a GPU-rendered display process, not a background server — if you close the window or the SSH link drops, everything inside dies. If you need sessions that survive a disconnect (e.g. long-running remote work), keep tmux/zellij for that specific case.
