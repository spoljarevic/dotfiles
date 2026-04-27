-- Application keybinds
hl.bind(mainMod .. " + Q",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd(lockscreen))
hl.bind(mainMod .. " + I",      hl.dsp.exec_cmd(hyprpicker))
hl.bind(mainMod .. " + S",      hl.dsp.exec_cmd(ScreenShot))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",      hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + C",      hl.dsp.window.close())
hl.bind(mainMod .. " + K",      hl.dsp.exit())

-- Media / function keys
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(brightness .. " up"),   { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightness .. " down"), { locked = true })
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(volume .. " up"),       { locked = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(volume .. " down"),     { locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(volume .. " mute"),     { locked = true })
hl.bind("XF86Bluetooth",         hl.dsp.exec_cmd(terminal .. " -e " .. bluetooth))
hl.bind("XF86PowerOff",          hl.dsp.exec_cmd(terminal .. " -e " .. power))
hl.bind("XF86WLAN",              hl.dsp.exec_cmd(terminal .. " -e " .. wifi))

-- Focus movement
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspace switching
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0",         hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Scroll through workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window management
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
