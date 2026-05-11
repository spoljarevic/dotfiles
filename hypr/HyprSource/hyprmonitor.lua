-- Main monitor on the left
hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@144.00",
    position = "0x0",
    scale    = 1,
})

-- Secondary monitor on the right
hl.monitor({
    output   = "DVI-D-1",
    mode     = "1920x1080@60.00",
    position = "1920x0",
    scale    = 1,
})
