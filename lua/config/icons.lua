local M = {}

M.branch = " "

M.copilot = {
    Error = " ",
    Inactive = " ",
    Warning = " ",
    Normal = " ",
}

M.diagnostics = {
    Error = " ",
    Warn = " ",
    Info = " ",
    Hint = " ",
}

M.fileformat = {
    unix = "",
    dos = "",
    mac = "",
}

M.bufferline = {
    active = "▎",
    modified = "●",
    separator = "│",
    trunc_left = " ",
    trunc_right = " ",
}

M.LeftSectionSep = ""
M.RightSectionSep = ""
M.LeftComponentSep = ""
M.RightComponentSep = ""

return M
