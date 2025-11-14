local M = {}

local palette = require("catppuccin.palettes").get_palette("mocha")

local colors = {
    bright_bg = palette.surface0,
    bright_fg = palette.text,
    red = palette.red,
    green = palette.green,
    blue = palette.blue,
    gray = palette.overlay0,
    orange = palette.peach,
    purple = palette.mauve,
    cyan = palette.sky,
    yellow = palette.yellow,
    diag_error = palette.red,
    diag_warn = palette.yellow,
    diag_info = palette.sky,
    diag_hint = palette.teal,
    git_del = palette.red,
    git_add = palette.green,
    git_change = palette.yellow,

    surface0 = palette.surface0,
    mantle = palette.mantle,
    text = palette.text,
    subtext0 = palette.subtext0,
}

function M.get() return colors end

return M
